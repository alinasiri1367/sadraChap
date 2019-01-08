import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadra2/models/product.dart';

class ProductCart extends StatelessWidget {
  final Product product;

  ProductCart({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return new Container(
      margin: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
      width: screenSize.width,
      child: new Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          new ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: new CachedNetworkImage(
              imageUrl: product.pic,
              placeholder: new Image(
                image: new AssetImage(
                    "assets/images/new_ui/placeholder-image.png"),
                fit: BoxFit.cover,
              ),
              errorWidget: new Icon(Icons.error),
              fit: BoxFit.fitWidth,
            ),
          ),
          new Container(
            padding:EdgeInsets.only(left: 2,right: 2),
            height: 25,
            width: 90,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.brightness_7,color: Colors.purple),
                new Padding(
                  padding: const EdgeInsets.only(top: 2),
                child: new Text(product.code,
                  style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                ),
                )
              ],
            ),
            decoration: new BoxDecoration(
              color: Colors.orange,
              borderRadius: new BorderRadius.circular(5)
            ),
          )
        ],
      ),
    );
  }
}
