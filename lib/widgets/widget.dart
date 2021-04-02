import 'package:flutter/material.dart';
import 'package:wallpaper_hub/models/wallpaper_model.dart';
import 'package:wallpaper_hub/views/image.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      text: '',
      style: TextStyle(fontSize: 16, color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: 'Wallpaper',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
        TextSpan(text: 'Hub', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageView(
                          imgUrl: wallpaper.src.potrait,
                        )));
          },
          child: Hero(
            tag: wallpaper.src.potrait,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  wallpaper.src.potrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
