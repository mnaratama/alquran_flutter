import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/db/bookmark.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:alquran/app/data/models/juz.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

class DetailJuzController extends GetxController {
  int index = 0;

  final player = AudioPlayer();

  Verses? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  // void addBookmark(
  //     bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
  //   Database db = await database.db;
  //
  //   bool flagExist = false;
  //
  //   if (lastRead == true) {
  //     await db.delete("bookmark", where: "last_read = 1");
  //   } else {
  //     List checkData = await db.query("bookmark",
  //         columns: ["surah", "ayat", "juz", "via", "index_ayat", "last_read"],
  //         where:
  //         "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' and ayat = ${ayat.number!.inSurah!} and juz = ${ayat.meta!.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 0");
  //     if (checkData.length != 0) {
  //       flagExist = true;
  //     }
  //   }
  //
  //   if (flagExist == false) {
  //     await db.insert("bookmark", {
  //       "surah": "${surah.name!.transliteration!.id!.replaceAll("'", "+")}",
  //       "ayat": ayat.number!.inSurah!,
  //       "juz": ayat.meta!.juz,
  //       "via": "surah",
  //       "index_ayat": indexAyat,
  //       "last_read": lastRead == true ? 1 : 0,
  //     });
  //
  //     Get.back();
  //     Get.snackbar("Berhasil", "Berhasil menambahkan bookmark",
  //         colorText: appWhite);
  //   } else {
  //     Get.back();
  //     Get.snackbar("Terjadi Kesalahan", "Bookmark telah tersedia",
  //         colorText: appWhite);
  //   }
  //
  //   var data = await db.query("bookmark");
  //   print(data);
  // }

  void stopAudio(Verses ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: e.message.toString());
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Tidak dapat pause audio.");
    }
  }

  void resumeAudio(Verses ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: e.message.toString());
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Tidak dapat pause audio.");
    }
  }

  void pauseAudio(Verses ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: e.message.toString());
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Tidak dapat pause audio.");
    }
  }

  void playAudio(Verses? ayat) async {
    if (ayat?.audio?.primary != null) {
      try {
        if(lastVerse == null){
          lastVerse = ayat;
        }
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(ayat!.audio!.primary ?? "");
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan", middleText: e.message.toString());
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Connection aborted: ${e.message}");
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Tidak dapat play audio.");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "URL Audio tidak ada / tidak dapat diakses");
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}