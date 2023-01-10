import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';
import 'package:alquran/app/data/models/juz.dart' as juz;

class DetailJuzView extends GetView<DetailJuzController> {
  int index = 0;
  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahInThisJuz = Get.arguments["surah"];

  @override
  Widget build(BuildContext context) {
    allSurahInThisJuz.forEach((element) {
      print(element.name!.transliteration!.id);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('JUZ ${detailJuz.juz}'),
          centerTitle: true,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: detailJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
                return Center(
                  child: Text("Tidak ada data."),
                );
              }
              juz.Verses ayat = detailJuz.verses![index];
              if (index != 0) {
                if (ayat.number?.inSurah == 1) {
                  controller.index++;
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: appPurpleLight2.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(Get.isDarkMode
                                              ? "assets/images/list_light.png"
                                              : "assets/images/list_dark.png"),
                                          fit: BoxFit.contain)),
                                  child: Center(
                                    child: Text("${ayat.number?.inSurah}"),
                                  )),
                              Text(
                                  "${allSurahInThisJuz[controller.index].name?.transliteration?.id ?? ''}",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16)),
                            ],
                          ),
                          GetBuilder<DetailJuzController>(
                              builder: (c) => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                                title: "BOOKMARK",
                                                middleText:
                                                    "Pilih jenis bookmark",
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        // c.addBookmark(
                                                        //     true,
                                                        //     snapshot
                                                        //         .data!,
                                                        //     ayat!,
                                                        //     index);
                                                      },
                                                      child: Text("LAST READ")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        // c.addBookmark(
                                                        //     false,
                                                        //     snapshot
                                                        //         .data!,
                                                        //     ayat!,
                                                        //     index);
                                                      },
                                                      child: Text("BOOKMARK")),
                                                ]);
                                          },
                                          icon: Icon(
                                              Icons.bookmark_add_outlined)),

                                      // kondisi => stop => button play
                                      // kondisi => playing => button pause & button stop
                                      // kondisi => pause => button resume & button stop
                                      (ayat?.kondisiAudio == "stop")
                                          ? IconButton(
                                              onPressed: () {
                                                c.playAudio(ayat);
                                              },
                                              icon: Icon(Icons.play_arrow))
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                (ayat?.kondisiAudio ==
                                                        "playing")
                                                    ? IconButton(
                                                        onPressed: () {
                                                          c.pauseAudio(ayat!);
                                                        },
                                                        icon: Icon(Icons.pause))
                                                    : IconButton(
                                                        onPressed: () {
                                                          c.resumeAudio(ayat!);
                                                        },
                                                        icon: Icon(
                                                            Icons.play_arrow)),
                                                IconButton(
                                                    onPressed: () {
                                                      c.stopAudio(ayat!);
                                                    },
                                                    icon: Icon(Icons.stop)),
                                              ],
                                            ),
                                    ],
                                  ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("${ayat!.text?.arab}",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25))),
                  SizedBox(height: 10),
                  Text("${ayat!.text?.transliteration?.en}",
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                  SizedBox(height: 25),
                  Text("${ayat!.translation?.id}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 50)
                ],
              );
            }));
  }
}
