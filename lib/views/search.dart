import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/models/wallpaper_model.dart';
import 'package:wallpaper_hub/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
  List<WallpaperModel> wallpapers = [];

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: brandName(),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "search", border: InputBorder.none),
                          controller: searchController,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            getSearchWallpapers(searchController.text);
                          },
                          child: Icon(Icons.search))
                    ],
                  ),
                ),
                wallpapersList(wallpapers: wallpapers, context: context)
              ],
            ),
          ),
        ));
  }

  getSearchWallpapers(String query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }
}
