import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DetaySayfa.dart';
import 'Kelimeler.dart';
import 'Kelimelerdao.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Sözlük',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<kelimeler>> tumKelimelerGoster() async {
    var kelimelerListesi = await Kelimelerdao().tumKelimeler();
    return kelimelerListesi;
  }

  Future<List<kelimeler>> aramaYap(String aramaKelimesi) async {
    var kelimelerListesi = await Kelimelerdao().kelimeAra(aramaKelimesi);
      return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
          decoration:
          InputDecoration(hintText: "Arama İçin Birşey Yazınız"),
          onChanged: (aramaSonucu) {
            print("Arama sonucu : $aramaSonucu");
            tumKelimelerGoster();
            setState(() {
              aramaKelimesi = aramaSonucu;
            });
          },
        )
            : Text("Sözlük Uygulaması"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {

                aramaYapiliyorMu = false;
                aramaKelimesi = "";
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<kelimeler>>(
        future:
        aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKelimelerGoster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kelimelerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kelimelerListesi.length,
              itemBuilder: (context, indeks) {
                var kelime = kelimelerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfa(
                              kelime: kelime,
                            )));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            kelime.ingilizce,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(kelime.turkce),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
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