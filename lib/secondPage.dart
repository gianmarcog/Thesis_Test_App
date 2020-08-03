
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'SmartHome.dart';

class SecondPage extends  StatefulWidget {

  SmartHome index;

  SecondPage(this.index);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  //Slider
  double sliderValue = 0;
  //Switcher
  bool switcher = false;
  //Download
  final imgUrl ="https://www.uni-kassel.de/upress/online/frei/978-3-89958-246-8.volltext.frei.pdf";
  bool downloading = false;
  var progressString ="";

  onSwitchValueChanged(bool newSwitcher){
    setState(() {
      switcher = newSwitcher;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(imgUrl, "${dir.path}/myimage.jpg", onReceiveProgress: (rec,total){
        print("Rec: $rec , Total: $total");

        setState(() {
          downloading = true;
          progressString = ((rec/total)*100).toStringAsFixed(0)+"%";
        });
      });
    } catch(e){
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The second page'),
      ),
          body:Container(
      child: Stack(
        //alignment: FractionalOffset(0.5, 0.15),
        children: <Widget>[
          Align(
          alignment: Alignment(0.0, -0.85),
          child: Image.asset(
          'assets/'+widget.index.image, width: 200.0, height: 200.0,
        ),),
        Align(
          alignment: Alignment(0.0, 0.0),
          child: Text(widget.index.name,
            style: TextStyle(
                fontSize: 21.0,
            ),)
        ),
        Align(
          alignment: Alignment(0.0, 0.1),
          child: Text(widget.index.description,
            style: TextStyle(
                fontSize: 15.0,
            ),)
        ),
        Align(
          alignment: Alignment(0.0, 0.2),
          child: CupertinoSlider (
          value: sliderValue,
          onChanged: (double val) {
            setState(() {
              sliderValue = val;
            });
          },
          min: 0,
          max: 100,
        )
        ),
        Align(
          alignment: Alignment(0.0, 0.25),
          child: Text(sliderValue.toStringAsFixed(0),
            style: TextStyle(
                fontSize: 15.0,
            ),)
        ),
        Align(
          alignment: Alignment(0.0, 0.35),
          child: Switch (
          value: switcher,
          onChanged: (newSwitcher) {
            setState(() {
              onSwitchValueChanged(newSwitcher);
            });
          },
        )
        ),
         Align(
          alignment: Alignment(0.0, 0.42),
          child: Text(switcher.toString(),
            style: TextStyle(
                fontSize: 15.0,
            ),)
        ),
      Align(
          alignment: Alignment(0.0, 0.6),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                downloadFile();
              });
            },
          ),

      ),
          Align(
              alignment: Alignment(0.0, 0.67),
              child: downloading?
                  Container(
                    height: 120.0,
                    width: 200.0,
                    child: Card(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          CircularProgressIndicator(),
                          SizedBox(height: 10.0,),
                          Text("Downloading File $progressString",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ):Text("Error")
          ),
      Align(
        alignment: Alignment(0.0, 0.67),
        child: FlatButton(
          child: Text("Start Downloading"),
          color: Colors.redAccent,
          textColor: Colors.white,
          onPressed: () async {
            final status = await Permission.storage.request();
            
            if(status.isGranted){

              final externalDir = await getExternalStorageDirectory();

              final ide = await   FlutterDownloader.enqueue(url: "https://www.uni-kassel.de/upress/online/frei/978-3-89958-246-8.volltext.frei.pdf",
                  savedDir: externalDir.path,
                  fileName: "download_pdf",
                  showNotification: true,
                  openFileFromNotification: true );
              }else {
                print("permission denied");
            }
        },
        ),

      ),
        ],
        ),
        
      ),
      );
  }
}