import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sadra2/components/cat_cart.dart';
import 'package:sadra2/components/product_cart.dart';
import 'dart:convert';
import 'dart:async';

import 'package:sadra2/models/cat.dart';
import 'package:sadra2/services/category_services.dart';

class ShowCat extends StatefulWidget {
  final int catId;
  final String title;
  String typeId = 'cat';
  bool _isLoading = true;
  String _TypeList = 'category';
  List<dynamic> _lists;
  bool _emptyList = false;

  ShowCat({@required this.catId, @required this.title});

  @override
  State<StatefulWidget> createState() => ShowCatState();
}

class ShowCatState extends State<ShowCat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() async {
    var respons = await CategoryServices2.getData(widget.catId);
    setState(() {
      if (respons != null) {
        widget._TypeList = respons['list_type'];
        widget._lists = respons['lists'];
      } else {
        widget._emptyList = true;
      }

      widget._isLoading = false;
    });
  }

  loadingView() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height;
    final double itemWidth = size.width;

    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Scaffold(
          appBar: AppBar(
            title: new Text(widget.title),
            centerTitle: true,
          ),
          body: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage("assets/images/new_ui/home/textur.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: widget._isLoading
                ? loadingView()
                : widget._emptyList
                    ? listIsEmpty()
                    : widget._TypeList == 'category'
                        ? categoryListGrid()
                        : productListView(),
          ),
        ));
  }

  Widget categoryListGrid() {
    print(widget._emptyList);
    return widget._lists.length == 0
        ? listIsEmpty()
        : new GridView.builder(
            itemCount: widget._lists.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return new CatCart(cat: widget._lists[index]);
            });
  }

  Widget productListView() {
    return widget._lists.length == 0
        ? listIsEmpty()
        : new ListView.builder(
            shrinkWrap: true,
            itemCount: widget._lists.length,
            itemBuilder: (BuildContext context, int index) {
              return new ProductCart(product: widget._lists[index]);
            });
  }

  Widget listIsEmpty() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("موردی برای نمایش وجود ندارد",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.indigo)),
          new RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text("بازگشت",
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
