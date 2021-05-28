import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeriTabaniYardimcisi {
  static final String veritabaniadi = "sozluk.sqlite";

  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(), veritabaniadi);
    print(veritabaniYolu);
    ByteData data = await rootBundle.load("db/$veritabaniadi");

    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(veritabaniYolu).writeAsBytes(bytes, flush: true);

    print("veri tabanı kopyalandı");

    return openDatabase(veritabaniYolu);
  }
}
