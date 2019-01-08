import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadra2/services/protfolio_services.dart';

class ProtfolioScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ProtfolioScreenState();
  }
}

class ProtfolioScreenState extends State<ProtfolioScreen> {
  List<dynamic> _protfolios = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProtfolio();
  }

  _getProtfolio() async {
    var response = await ProtfolioServices.getProtfolios();
    print(response);
    // print('dddddddddddddddddddddd');
    setState(() {
      _protfolios = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Scaffold(
          appBar: AppBar(
            title: new Text("نمونه کار ها"),
            centerTitle: true,
          ),
          body: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/new_ui/home/textur.png"),
                  fit: BoxFit.cover),
            ),
            child: _isLoading
                ? loadingView()
                : new ListView.builder(
                itemCount: _protfolios.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      height: 160,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                width: screenSize.width*0.3,
                                padding: const EdgeInsets.all(3),
                                decoration: new BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: new BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0)),
                                  border: new Border.all(
                                      color: Colors.purple,
                                  ),
                                ),
                                child: new Row(
                                  children: <Widget>[
                                    new Icon(Icons.arrow_right,color: Colors.white),
                                    new Divider(),
                                    new Text(_protfolios[index]['title'],
                                      style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              new Container(
                               // margin: EdgeInsets.only(top: 15),
                                width: screenSize.width*0.5,
                                height: 3,
                                color: Colors.purple,
                              ),
                              new Container(
                                alignment: Alignment.center,
                                width: screenSize.width*0.2,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text("بیـشتر",style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.purple,)),
                                    new Icon(Icons.keyboard_arrow_left,color: Colors.purple,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          new Container(
                            height: 120,
                            child: new ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: _protfolios[index]['protfolio']['data'].length,
                                itemBuilder:
                                    (BuildContext context2, int index2) {
                                  return new Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: new ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: new CachedNetworkImage(
                                        imageUrl: _protfolios[index]
                                        ['protfolio']['data'][index2]
                                        ['pic'],
                                        placeholder: new Image(
                                          image: new AssetImage(
                                              "assets/images/new_ui/placeholder-image.png"),
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: new Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ));
                }),
          ),
        )
    );
  }

  Widget loadingView() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}
