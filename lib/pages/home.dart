import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sadra2/models/cat.dart';
import 'package:sadra2/models/page.dart';
import 'package:sadra2/pages/cat.dart';
import 'package:sadra2/pages/page.dart';
import 'package:sadra2/pages/protfolio.dart';
import 'package:sadra2/services/home_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Cat> _cats = [];
  bool _isLoading = true;
  Page _banner = new Page();
  int _defautlMargin = 16;

  @override
  void initState() {
    super.initState();
    _getMainCats();
    // _getBanner();
  }

  /*_getBanner() async {
    var res = await CategoryServices.getPage('banner');
    setState(() {
      _banner = res;
    });
  }*/

  _getMainCats() async {
    if (await checkConnectionInternet()) {
      var res = await CategoryServices.getMainCats();
      var res_banner = await CategoryServices.getPage('banner');
      setState(() {
        _cats = res;
        _banner = res_banner;
        _isLoading = false;
      });
    } else {
      print('ffffffgggggggggggggggggggggg');
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: new Duration(hours: 2),
          content: new GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
              _getMainCats();
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("از اتصال دستگاه به اینترنت مطمئن شوید",
                    style: new TextStyle(fontFamily: "Vazir")),
                new Icon(
                  Icons.wifi_lock,
                  color: Colors.white,
                )
              ],
            ),
          )));
    }
  }

  Widget loadingView(size) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new Stack(
        children: <Widget>[
          new Container(
            height: size.height,
            width: size.width,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/new_ui/intro.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          new Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: new Align(
                alignment: Alignment.bottomCenter,
                child: new CircularProgressIndicator(),
              )),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (context) {
              return new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new AlertDialog(
                    title: new Text("آیا از خروج مطمئنید؟"),
                    content:
                    new Text("با انتخاب گزینه بله از اپلیکیشن خارج خواهید شد"),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: new Text("بله",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green))),
                      new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: new Text("خیر",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.red)))
                    ],
                  )
              );
            }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // TODO: implement build
    return _isLoading
        ? loadingView(screenSize)
        : new WillPopScope(
            child: new Scaffold(
              body: new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: AssetImage("assets/images/new_ui/home/textur.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Column(
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          _navigationToCategory(
                              context, _banner.catId, _banner.title);
                        },
                        child: new Container(
                          //padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(top: 24.0),
                          height: (screenSize.height * .13),
                          width: screenSize.width,
                          child: new ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: new CachedNetworkImage(
                              imageUrl: _banner.pic,
                              placeholder: new Image(
                                image: new AssetImage(
                                    "assets/images/new_ui/placeholder-image.png"),
                                fit: BoxFit.cover,
                              ),
                              errorWidget: new Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      new GestureDetector(
                          onTap: () {
                            _navigationToCategory(
                                context, _cats[0].id, _cats[0].title);
                          },
                          child: new Container(
                            padding: EdgeInsets.all(01),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            height: (screenSize.height * .19),
                            width: screenSize.width,
                            child: new ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: new CachedNetworkImage(
                                imageUrl: _cats[0].pic,
                                placeholder: new Image(
                                  image: new AssetImage(
                                      "assets/images/new_ui/placeholder-image.png"),
                                  fit: BoxFit.cover,
                                ),
                                // errorWidget: new Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new GestureDetector(
                              onTap: () {
                                _navigationToCategory(
                                    context, _cats[1].id, _cats[1].title);
                              },
                              child: new Container(
                                /* padding: EdgeInsets.all(8.0),*/
                                height: (screenSize.height * .16),
                                width: (screenSize.width / 3) - 10,
                                child: new ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: new CachedNetworkImage(
                                    imageUrl: _cats[1].pic,
                                    placeholder: new Image(
                                      image: new AssetImage(
                                          "assets/images/new_ui/placeholder-image.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: new Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          new GestureDetector(
                              onTap: () {
                                _navigationToCategory(
                                    context, _cats[2].id, _cats[2].title);
                              },
                              child: new Container(
                                //padding: EdgeInsets.all(8.0),
                                height: (screenSize.height * .16),
                                width: (screenSize.width / 3) - 10,
                                child: new ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: new CachedNetworkImage(
                                    imageUrl: _cats[2].pic,
                                    placeholder: new Image(
                                      image: new AssetImage(
                                          "assets/images/new_ui/placeholder-image.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: new Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          new GestureDetector(
                              onTap: () {
                                _navigationToCategory(
                                    context, _cats[3].id, _cats[3].title);
                              },
                              child: new Container(
                                //padding: EdgeInsets.all(8.0),
                                height: (screenSize.height * .16),
                                width: (screenSize.width / 3) - 10,
                                child: new ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: new CachedNetworkImage(
                                    imageUrl: _cats[3].pic,
                                    placeholder: new Image(
                                      image: new AssetImage(
                                          "assets/images/new_ui/placeholder-image.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: new Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new GestureDetector(
                            onTap: () {
                              _navigatorToPage(context, 'services');
                            },
                            child: new Container(
                              margin: EdgeInsets.only(top: 8, bottom: 8),
                              height: (screenSize.height * .23),
                              width: (screenSize.width * .40) - _defautlMargin,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  /*color: Colors.red,*/
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new AssetImage(
                                        "assets/images/new_ui/home/6.png"),
                                  )),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              _navigationToProtfolio(context);
                            },
                            child: new Container(
                              margin: EdgeInsets.only(top: 8, bottom: 8),
                              height: (screenSize.height * .23),
                              width: (screenSize.width * .60) - _defautlMargin,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  /*color: Colors.blueAccent,*/
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage(
                                        "assets/images/new_ui/home/5.png"),
                                  )),
                            ),
                          )
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: (screenSize.height * .08),
                            width: (screenSize.width * .60) - _defautlMargin,
                            //child: Center(child: Text("پرداخت آنلاین")),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                //  color: Colors.green,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new AssetImage(
                                      "assets/images/new_ui/home/8.png"),
                                )),
                          ),
                          new Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: (screenSize.height * .08),
                            width: (screenSize.width * .40) - _defautlMargin,
                            /* child: Center(child: Text("مسابقه و نظرسنجی")),*/
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                /*color: Colors.yellow,*/
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new AssetImage(
                                      "assets/images/new_ui/home/7.png"),
                                )),
                          )
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: (screenSize.height * .08),
                            width: (screenSize.width * .40) - _defautlMargin,
                            /*child: Center(child: Text("علاقه مندی ها")),*/
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                /*color: Colors.orange,*/
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new AssetImage(
                                      "assets/images/new_ui/home/10.png"),
                                )),
                          ),
                          new GestureDetector(
                            onTap: () {
                              _navigatorToPage(context, 'contactUs');
                            },
                            child: new Container(
                              margin: EdgeInsets.only(bottom: 8),
                              height: (screenSize.height * .08),
                              width: (screenSize.width * .60) - _defautlMargin,
                              /*child: Center(child: Text("تماس با ما")),*/
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  /*color: Colors.grey,*/
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new AssetImage(
                                        "assets/images/new_ui/home/9.png"),
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            onWillPop: _onWillPop);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _navigatorToPage(BuildContext context, String s) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ShowPage(pageName: s)),
    );
  }

  void _navigationToCategory(BuildContext context, int catId, String title) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new ShowCat(catId: catId, title: title)),
    );
  }

  Future<bool> checkConnectionInternet() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  void _navigationToProtfolio(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new ProtfolioScreen()));
  }
}
