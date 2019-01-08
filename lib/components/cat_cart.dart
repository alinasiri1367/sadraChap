import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadra2/models/cat.dart';
import 'package:sadra2/pages/cat.dart';

class CatCart extends StatelessWidget {
  final Cat cat;

  CatCart({@required this.cat});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
        onTap: () {
          _navigationToCategory(context, cat.id,cat.title);
        },
        child: new Container(
          width: 100,
          height: 100,
          margin: new EdgeInsets.all(5),
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: new CachedNetworkImage(
              imageUrl: cat.pic == null ? "" : cat.pic,
              placeholder: new Image(
                image: new AssetImage(
                    "assets/images/new_ui/placeholder-image.png"),
                fit: BoxFit.cover,
              ),
              errorWidget: new Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  void _navigationToCategory(BuildContext context, int catId,String title) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ShowCat(catId: catId,title: title)),
    );
  }
}
