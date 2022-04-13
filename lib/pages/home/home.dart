import 'dart:convert';

import 'package:desjustamobile/data/data.dart';
import 'package:desjustamobile/model/categories_model.dart';
import 'package:desjustamobile/model/wallpaper_model.dart';
import 'package:desjustamobile/pages/categorias/categories.dart';
import 'package:desjustamobile/pages/search/search.dart';
import 'package:desjustamobile/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();
  var API_KEY = '563492ad6f9170000100000180b51c2d91f540b397d2e4da0ae84694';

  getTrendingWallpaper() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=15",
        headers: {"Authorization": API_KEY});

    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Pesquisar',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(
                                searchQuery: searchController.text,
                              ),
                            ));
                      },
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      //  wallpapers[index].src.potrait;
                      return CategoriesTile(
                        title: categories[index].categoriesName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
              ),
              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers, context)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.title, @required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                      categorieName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imgUrl,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
