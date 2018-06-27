import 'package:flutter/material.dart';
import 'package:startup_namer/http_simple.dart';
class Simple extends StatefulWidget {
  Simple();
  @override
  createState() => new SimpleState();
}

class SimpleState extends State<Simple> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    '我在这里等着你',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                new Text(
                  '不得了暗示的啊',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
//            new Icon(
//              Icons.star,
//              color: Colors.red[500],
//            ),
//            new Text('41'),
          new FavoriteWidget(),
        ],
      ),
    );




    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: FutureBuilder<Post>(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.title);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return LinearProgressIndicator();
        },
      )
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Top Lakes'),
      ),
      body: new ListView(
        children: [
          new FadeInImage.assetNetwork(placeholder: 'images/lake.jpg',
            image: 'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
//          new Image.network(
//              'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
//              width: 600.0,
//              height: 240.0,
//              fit: BoxFit.cover,
//          ),
//          new Image.asset(
//            'images/lake.jpg',
//            width: 600.0,
//            height: 240.0,
//            fit: BoxFit.cover,
//          ),
          titleSection,
          new CallWidget(),
          textSection,
        ],
      ),
    );
  }
}
class CallWidget extends StatefulWidget{
  @override
  _CallWidgetState createState() => new _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget>{
  @override
  Widget build(BuildContext context) {
    Column buildButtonColumn(Icon icon, String label) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new IconButton(icon: icon,color: color,onPressed: (){
            final snackBar = SnackBar(
              content: Text('Yay! A SnackBar!'),
              action: SnackBarAction(
                label: '取消',
                onPressed: () {
                  // Some code to undo the change!
                },
              ),
            );

            // Find the Scaffold in the Widget tree and use it to show a SnackBar!
            Scaffold.of(context).showSnackBar(snackBar);

          },),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }
    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(new Icon(Icons.call), 'CALL'),
          buildButtonColumn(new Icon(Icons.near_me), 'ROUTE'),
          buildButtonColumn(new Icon(Icons.share), 'SHARE'),
        ],
      ),
    );
    return buttonSection;
  }


}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => new _FavoriteWidgetState();
}
class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        // Otherwise, favorite it.
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
            icon: (_isFavorited
                ? new Icon(Icons.star)
                : new Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        new SizedBox(
          width: 18.0,
          child: new Container(
            child: new Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
/// Tab
class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
