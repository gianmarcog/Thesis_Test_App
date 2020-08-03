import 'package:flutter/material.dart';
import './SmartHome.dart';
import './data.dart';
import 'secondPage.dart';

class HomePage extends StatelessWidget {

  List<SmartHome> _listOfSmartHome = Data.listOfSmartHome();

  Widget build(BuildContext context) {
  
  return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Cites around world",
          style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: getHomePageBody(context)));
}

getHomePageBody(BuildContext context) {
  return ListView.builder(
    itemCount: _listOfSmartHome.length,
    itemBuilder: _getItemUI,
    padding: EdgeInsets.all(0.0),
  );
}

Widget _getItemUI(BuildContext context, int index) {
  
  return new Card(
      child: new Column(
    children: <Widget>[
      Container(height: 20),
      new ListTile(
        leading: new Image.asset( "assets/" + _listOfSmartHome[index].image
        ),

        title: new Text(
          _listOfSmartHome[index].name,
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        subtitle: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(height: 25.0),
              new Text('Description: ${_listOfSmartHome[index].description}',
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.normal)),
            ]),
        //trailing: ,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(_listOfSmartHome[index])));
        },
      ),
    ],
  ));
  }
}