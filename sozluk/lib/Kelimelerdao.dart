import 'Kelimeler.dart';
import 'VeriTabaniYardimcisi.dart';

class Kelimelerdao {

  Future<List<kelimeler>> tumKelimeler() async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");
    return List.generate(maps.length, (i){
      var satir = maps[i];
      return kelimeler(satir["kelime_id"],satir["ingilizce"],satir["turkce"]);
    });
  }

  Future<List<kelimeler>> kelimeAra(String aramaKelimesi) async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$aramaKelimesi%' ");

    return List.generate(maps.length, (i){
      var satir = maps[i];
      return kelimeler(satir["kelime_id"],satir["ingilizce"],satir["turkce"]);
    });
  }






}