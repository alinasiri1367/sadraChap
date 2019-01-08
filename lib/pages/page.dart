import 'package:flutter/material.dart';
import 'package:sadra2/services/page_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowPage extends StatefulWidget {
  final String pageName;

  bool _isLoading = true;
  String _pic = "";

  ShowPage({this.pageName});

  @override
  State<StatefulWidget> createState() => ShowPageState();
}

class ShowPageState extends State<ShowPage>
    with AutomaticKeepAliveClientMixin<ShowPage> {
  @override
  void initState() {
    // TODO: implement initState
    _getPage();
  }

  _getPage() async {
    var result = await PageServices.getPage(widget.pageName);
    setState(() {
      widget._pic = result;
      widget._isLoading = false;
    });
  }

  Map<String, String> translate = <String, String>{
    "services": "خدمات ما",
    "contactUs": "تماس با ما",
  };

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return widget._isLoading
        ? loadingView()
        : Directionality(
            textDirection: TextDirection.rtl,
            child: new Scaffold(
              appBar: AppBar(
                title: new Text(translate[widget.pageName]),
              ),
              body: new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: AssetImage("assets/images/new_ui/home/textur.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Container(
                    width: screenSize.width,
                    child: new ListView(
                      children: <Widget>[
                        new CachedNetworkImage(
                          imageUrl: widget._pic,
                          placeholder: new CircularProgressIndicator(),
                          // errorWidget: new Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  loadingView() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => null;
}
