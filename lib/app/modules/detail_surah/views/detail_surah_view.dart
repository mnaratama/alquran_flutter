import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('SURAH ${Get.arguments["name"].toString().toUpperCase()}'),
          centerTitle: true,
        ),
        body: FutureBuilder<detail.DetailSurah>(
            future:
                controller.getDetailSurah(Get.arguments["number"].toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text("Tidak ada data."),
                );
              }

              if (Get.arguments["bookmark"] != null) {
                bookmark = Get.arguments["bookmark"];
                  controller.scrollC.scrollToIndex(
                      int.parse(bookmark!["index_ayat"]) + 2,
                      preferPosition: AutoScrollPosition.begin);
              }

              detail.DetailSurah surah = snapshot.data!;

              List<Widget> allAyat =
                  List.generate(snapshot.data?.verses?.length ?? 0, (index) {
                detail.Verse? ayat = snapshot.data?.verses?[index];
                return AutoScrollTag(
                    key: ValueKey(index + 2),
                    controller: controller.scrollC,
                    index: index + 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: appPurpleLight2.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Get.isDarkMode
                                                ? "assets/images/list_light.png"
                                                : "assets/images/list_dark.png"),
                                            fit: BoxFit.contain)),
                                    child: Center(
                                      child: Text("${index + 1}"),
                                    )),
                                GetBuilder<DetailSurahController>(
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
                                                            onPressed:
                                                                () async {
                                                              await c
                                                                  .addBookmark(
                                                                      true,
                                                                      snapshot
                                                                          .data!,
                                                                      ayat!,
                                                                      index);
                                                              homeC.update();
                                                            },
                                                            child: Text(
                                                                "LAST READ")),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              c.addBookmark(
                                                                  false,
                                                                  snapshot
                                                                      .data!,
                                                                  ayat!,
                                                                  index);
                                                            },
                                                            child: Text(
                                                                "BOOKMARK")),
                                                      ]);
                                                },
                                                icon: Icon(Icons
                                                    .bookmark_add_outlined)),

                                            // kondisi => stop => button play
                                            // kondisi => playing => button pause & button stop
                                            // kondisi => pause => button resume & button stop
                                            (ayat?.kondisiAudio == "stop")
                                                ? IconButton(
                                                    onPressed: () {
                                                      c.playAudio(ayat);
                                                    },
                                                    icon:
                                                        Icon(Icons.play_arrow))
                                                : Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      (ayat?.kondisiAudio ==
                                                              "playing")
                                                          ? IconButton(
                                                              onPressed: () {
                                                                c.pauseAudio(
                                                                    ayat!);
                                                              },
                                                              icon: Icon(
                                                                  Icons.pause))
                                                          : IconButton(
                                                              onPressed: () {
                                                                c.resumeAudio(
                                                                    ayat!);
                                                              },
                                                              icon: Icon(Icons
                                                                  .play_arrow)),
                                                      IconButton(
                                                          onPressed: () {
                                                            c.stopAudio(ayat!);
                                                          },
                                                          icon:
                                                              Icon(Icons.stop)),
                                                    ],
                                                  ),
                                          ],
                                        ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("${ayat!.text?.arab}",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 25)),
                        SizedBox(height: 10),
                        Text("${ayat!.text?.transliteration?.en}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic)),
                        SizedBox(height: 25),
                        Text("${ayat!.translation?.id}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 50)
                      ],
                    ));
              });

              return ListView(
                controller: controller.scrollC,
                padding: EdgeInsets.all(20),
                children: [
                  AutoScrollTag(
                    key: ValueKey(0),
                    index: 0,
                    controller: controller.scrollC,
                    child: GestureDetector(
                      onTap: () => Get.dialog(Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? appPurpleLight2.withOpacity(0.3)
                                  : appWhite),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Tafsir ${surah.name?.transliteration!.id}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(
                                  "${surah.tafsir?.id ?? 'Tidak ada tafsir pada surah ini.'}",
                                  textAlign: TextAlign.justify)
                            ],
                          ),
                        ),
                      )),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [appPurpleLight, appPurpleDark])),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                    '${surah.name?.transliteration!.id?.toUpperCase() ?? 'Error..'}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: appWhite)),
                                Text(
                                    '( ${surah.name?.transliteration!.id?.toUpperCase() ?? 'Error..'} )',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: appWhite)),
                                SizedBox(height: 10),
                                Text(
                                    '${surah.numberOfVerses ?? 'Error..'} Ayat | ${surah.revelation?.id ?? 'Error..'}',
                                    style: TextStyle(
                                        fontSize: 16, color: appWhite)),
                              ],
                            ),
                          )),
                    ),
                  ),
                  AutoScrollTag(
                    key: ValueKey(1),
                    index: 1,
                    controller: controller.scrollC,
                    child: SizedBox(height: 20),
                  ),
                  ...allAyat
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: snapshot.data?.verses?.length ?? 0,
                  //     itemBuilder: (context, index) {
                  //       if (snapshot.data?.verses?.length == 0) {
                  //         return SizedBox();
                  //       }
                  //       detail.Verse? ayat = snapshot.data?.verses?[index];
                  //       return AutoScrollTag(
                  //           key: ValueKey(index + 2),
                  //           controller: controller.scrollC,
                  //           index: index + 2,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               Container(
                  //                 decoration: BoxDecoration(
                  //                     color: appPurpleLight2.withOpacity(0.3),
                  //                     borderRadius: BorderRadius.circular(10)),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.symmetric(
                  //                       vertical: 5, horizontal: 10),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Container(
                  //                           height: 40,
                  //                           width: 40,
                  //                           decoration: BoxDecoration(
                  //                               image: DecorationImage(
                  //                                   image: AssetImage(Get
                  //                                           .isDarkMode
                  //                                       ? "assets/images/list_light.png"
                  //                                       : "assets/images/list_dark.png"),
                  //                                   fit: BoxFit.contain)),
                  //                           child: Center(
                  //                             child: Text("${index + 1}"),
                  //                           )),
                  //                       GetBuilder<DetailSurahController>(
                  //                           builder: (c) => Row(
                  //                                 children: [
                  //                                   IconButton(
                  //                                       onPressed: () {
                  //                                         Get.defaultDialog(
                  //                                             title: "BOOKMARK",
                  //                                             middleText:
                  //                                                 "Pilih jenis bookmark",
                  //                                             actions: [
                  //                                               ElevatedButton(
                  //                                                   onPressed:
                  //                                                       () async {
                  //                                                     await c.addBookmark(
                  //                                                         true,
                  //                                                         snapshot
                  //                                                             .data!,
                  //                                                         ayat!,
                  //                                                         index);
                  //                                                     homeC
                  //                                                         .update();
                  //                                                   },
                  //                                                   child: Text(
                  //                                                       "LAST READ")),
                  //                                               ElevatedButton(
                  //                                                   onPressed:
                  //                                                       () {
                  //                                                     c.addBookmark(
                  //                                                         false,
                  //                                                         snapshot
                  //                                                             .data!,
                  //                                                         ayat!,
                  //                                                         index);
                  //                                                   },
                  //                                                   child: Text(
                  //                                                       "BOOKMARK")),
                  //                                             ]);
                  //                                       },
                  //                                       icon: Icon(Icons
                  //                                           .bookmark_add_outlined)),
                  //
                  //                                   // kondisi => stop => button play
                  //                                   // kondisi => playing => button pause & button stop
                  //                                   // kondisi => pause => button resume & button stop
                  //                                   (ayat?.kondisiAudio ==
                  //                                           "stop")
                  //                                       ? IconButton(
                  //                                           onPressed: () {
                  //                                             c.playAudio(ayat);
                  //                                           },
                  //                                           icon: Icon(Icons
                  //                                               .play_arrow))
                  //                                       : Row(
                  //                                           mainAxisSize:
                  //                                               MainAxisSize
                  //                                                   .min,
                  //                                           children: [
                  //                                             (ayat?.kondisiAudio ==
                  //                                                     "playing")
                  //                                                 ? IconButton(
                  //                                                     onPressed:
                  //                                                         () {
                  //                                                       c.pauseAudio(
                  //                                                           ayat!);
                  //                                                     },
                  //                                                     icon: Icon(
                  //                                                         Icons
                  //                                                             .pause))
                  //                                                 : IconButton(
                  //                                                     onPressed:
                  //                                                         () {
                  //                                                       c.resumeAudio(
                  //                                                           ayat!);
                  //                                                     },
                  //                                                     icon: Icon(
                  //                                                         Icons
                  //                                                             .play_arrow)),
                  //                                             IconButton(
                  //                                                 onPressed:
                  //                                                     () {
                  //                                                   c.stopAudio(
                  //                                                       ayat!);
                  //                                                 },
                  //                                                 icon: Icon(Icons
                  //                                                     .stop)),
                  //                                           ],
                  //                                         ),
                  //                                 ],
                  //                               ))
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(height: 20),
                  //               Text("${ayat!.text?.arab}",
                  //                   textAlign: TextAlign.end,
                  //                   style: TextStyle(fontSize: 25)),
                  //               SizedBox(height: 10),
                  //               Text("${ayat!.text?.transliteration?.en}",
                  //                   textAlign: TextAlign.end,
                  //                   style: TextStyle(
                  //                       fontSize: 18,
                  //                       fontStyle: FontStyle.italic)),
                  //               SizedBox(height: 25),
                  //               Text("${ayat!.translation?.id}",
                  //                   textAlign: TextAlign.justify,
                  //                   style: TextStyle(fontSize: 18)),
                  //               SizedBox(height: 50)
                  //             ],
                  //           ));
                  //     })
                ],
              );
            }));
  }
}
