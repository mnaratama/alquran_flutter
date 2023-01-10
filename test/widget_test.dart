import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.quran.gading.dev/surah/86/1");
  var res = await http.get(url);

  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

  Surah surahAnnas = Surah.fromJson(data[113]);

  Uri urlAnnas = Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  var resAnnas = await http.get(urlAnnas);

  Map<String, dynamic> dataAnnas = (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];

  // data dari api ( raw data ) -> Model ( yg sudah disiapin )
  DetailSurah annas = DetailSurah.fromJson(dataAnnas);

  print(annas.verses![0].text!.arab);
}
