import 'package:flutter/material.dart';
import 'Kelimeler.dart';
import 'package:flutter_tts/flutter_tts.dart';


class DetaySayfa extends StatefulWidget{
  kelimeler kelime;

  DetaySayfa({this.kelime});

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa>{
  final FlutterTts tts = new FlutterTts();
  @override
  Future _speak() async {
    tts.setLanguage("en-Us");
    tts.speak(widget.kelime.ingilizce);
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(widget.kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.pink),),
            Text(widget.kelime.turkce,style: TextStyle(fontSize: 40),),
            IconButton(
                icon: Icon(Icons.record_voice_over),
                onPressed: _speak
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.only(left: 20.0,top: 1.0,right: 20.0,bottom: 1.0),
          child : Text("Created by HAYDAR ALİ SATAR",
            style : TextStyle(
              color: Colors.black,
              backgroundColor: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),

          ),
        )

      ],

    );
  }
}