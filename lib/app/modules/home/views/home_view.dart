import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/surah.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Al Quran Apps'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Get.toNamed(Routes.SEARCH),
                icon: Icon(Icons.search))
          ],
        ),
        body: DefaultTabController(
            length: 3,
            child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Assalamualaikum",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    GetBuilder<HomeController>(
                        builder: (c) => FutureBuilder<Map<String, dynamic>?>(
                            future: c.getLastRead(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(colors: [
                                        appPurpleLight,
                                        appPurpleDark
                                      ])),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  bottom: -50,
                                                  right: 0,
                                                  child: Opacity(
                                                      opacity: 0.7,
                                                      child: Container(
                                                        width: 200,
                                                        height: 200,
                                                        child: Image.asset(
                                                            "assets/images/alquran.png",
                                                            fit:
                                                                BoxFit.contain),
                                                      ))),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(children: [
                                                        Icon(
                                                            Icons
                                                                .menu_book_rounded,
                                                            color: appWhite),
                                                        SizedBox(width: 10),
                                                        Text("Terakhir dibaca",
                                                            style: TextStyle(
                                                                color:
                                                                    appWhite))
                                                      ]),
                                                      SizedBox(height: 30),
                                                      Text("Loading...",
                                                          style: TextStyle(
                                                              color: appWhite,
                                                              fontSize: 20)),
                                                      SizedBox(height: 10),
                                                      Text(" ",
                                                          style: TextStyle(
                                                              color: appWhite))
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              }
                              Map<String, dynamic>? lastRead = snapshot.data;
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      appPurpleLight,
                                      appPurpleDark
                                    ])),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onLongPress: () {
                                        if (lastRead != null)
                                          Get.defaultDialog(
                                              title: "Delete Last Read",
                                              middleText:
                                                  "Are you sure to delete this last read bookmark ?",
                                              actions: [
                                                OutlinedButton(
                                                    onPressed: () => Get.back(),
                                                    child: Text("CANCEL")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      controller.deleteLastRead(
                                                          lastRead['id']);
                                                    },
                                                    child: Text("DELETE")),
                                              ]);
                                      },
                                      onTap: () {
                                        if (lastRead != null) {
                                          Get.toNamed(Routes.DETAIL_SURAH,
                                              arguments: {
                                                "name": lastRead["surah"].toString().replaceAll("+", "'"),
                                                "number": lastRead["number_surah"],
                                                "bookmark": lastRead
                                              });
                                          print(lastRead);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                bottom: -50,
                                                right: 0,
                                                child: Opacity(
                                                    opacity: 0.7,
                                                    child: Container(
                                                      width: 200,
                                                      height: 200,
                                                      child: Image.asset(
                                                          "assets/images/alquran.png",
                                                          fit: BoxFit.contain),
                                                    ))),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Icon(
                                                          Icons
                                                              .menu_book_rounded,
                                                          color: appWhite),
                                                      SizedBox(width: 10),
                                                      Text("Terakhir dibaca",
                                                          style: TextStyle(
                                                              color: appWhite))
                                                    ]),
                                                    SizedBox(height: 30),
                                                    Text(
                                                        lastRead == null
                                                            ? ""
                                                            : "${lastRead['surah'].toString().replaceAll("+", "'")}",
                                                        style: TextStyle(
                                                            color: appWhite,
                                                            fontSize: 20)),
                                                    SizedBox(height: 10),
                                                    Text(
                                                        lastRead == null
                                                            ? "Belum ada data"
                                                            : "Juz ${lastRead['juz']} | Ayat ${lastRead['ayat']}",
                                                        style: TextStyle(
                                                            color: appWhite))
                                                  ],
                                                ))
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            })),
                    TabBar(tabs: [
                      Tab(child: Text("Surah")),
                      Tab(child: Text("Juz")),
                      Tab(child: Text("Bookmark")),
                    ]),
                    Expanded(
                        child: TabBarView(children: [
                      FutureBuilder<List<Surah>>(
                          future: controller.getAllSurah(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text("Tidak ada data."),
                              );
                            }
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Surah surah = snapshot.data![index];
                                  return ListTile(
                                    onTap: () {
                                      Get.toNamed(Routes.DETAIL_SURAH,
                                          arguments: {
                                            "name":
                                                surah.name!.transliteration!.id,
                                            "number": surah.number!,
                                          });
                                    },
                                    leading: Obx(() => Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(controller
                                                          .isDark.isTrue
                                                      ? "assets/images/list_light.png"
                                                      : "assets/images/list_dark.png"))),
                                          child: Center(
                                              child: Text("${surah.number}")),
                                        )),
                                    title: Text(
                                        "${surah.name?.transliteration?.id ?? 'Error..'}"),
                                    subtitle: Text(
                                        "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error..'}",
                                        style:
                                            TextStyle(color: Colors.grey[500])),
                                    trailing: Text(
                                        "${surah.name?.short ?? 'Error..'}"),
                                  );
                                });
                          }),
                      FutureBuilder<List<juz.Juz>>(
                        future: controller.getAllJuz(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text("Tidak ada data."),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                // contoh pertama adalah juz 1 => index ke 0
                                juz.Juz detailJuz = snapshot.data![index];

                                String nameStart = detailJuz.juzStartInfo
                                        ?.split(" - ")
                                        .first ??
                                    "";
                                String nameEnd =
                                    detailJuz.juzEndInfo?.split(" - ").first ??
                                        "";

                                List<Surah> rawAllSurahInJuz = [];
                                List<Surah> allSurahInJuz = [];

                                for (Surah item in controller.allSurah) {
                                  rawAllSurahInJuz.add(item);
                                  if (item.name!.transliteration!.id ==
                                      nameEnd) {
                                    break;
                                  }
                                }

                                for (Surah item
                                    in rawAllSurahInJuz.reversed.toList()) {
                                  allSurahInJuz.add(item);
                                  if (item.name!.transliteration!.id ==
                                      nameStart) {
                                    break;
                                  }
                                }

                                return ListTile(
                                    onTap: () {
                                      Get.toNamed(Routes.DETAIL_JUZ,
                                          arguments: {
                                            "juz": detailJuz,
                                            "surah":
                                                allSurahInJuz.reversed.toList()
                                          });
                                    },
                                    leading: Obx(() => Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(controller
                                                          .isDark.isTrue
                                                      ? "assets/images/list_light.png"
                                                      : "assets/images/list_dark.png"))),
                                          child: Center(
                                              child: Text("${index + 1}")),
                                        )),
                                    title: Text("Juz ${index + 1}"),
                                    isThreeLine: true,
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "Mulai dari ${detailJuz.juzStartInfo}"),
                                        Text("Sampai ${detailJuz.juzEndInfo}"),
                                      ],
                                    )
                                    // trailing: Text(
                                    //     "${surah.name?.short ?? 'Error..'}",
                                    //     style: TextStyle(color: appPurpleDark)),
                                    );
                              });
                        },
                      ),
                      GetBuilder<HomeController>(builder: (c) {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                            future: c.getBookmark(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.data?.length == 0) {
                                return Center(
                                  child: Text("Bookmark tidak tersedia"),
                                );
                              }

                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> data =
                                        snapshot.data![index];
                                    return ListTile(
                                      onTap: () {
                                        Get.toNamed(Routes.DETAIL_SURAH,
                                            arguments: {
                                              "name": data["surah"].toString().replaceAll("+", "'"),
                                              "number": data["number_surah"],
                                              "bookmark": data
                                            });
                                        print(data);
                                      },
                                      leading: Obx(() => Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(controller
                                                            .isDark.isTrue
                                                        ? "assets/images/list_light.png"
                                                        : "assets/images/list_dark.png"))),
                                            child: Center(
                                                child: Text("${index + 1}")),
                                          )),
                                      title: Text(
                                          "${data['surah'].toString().replaceAll("+", "'")}"),
                                      subtitle: Text(
                                          "Ayat ${data['ayat']} - via ${data['via']}",
                                          style: TextStyle(
                                              color: Colors.grey[500])),
                                      trailing: IconButton(
                                        onPressed: () {
                                          c.deleteBookmark(data['id']);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    );
                                  });
                            });
                      }),
                    ]))
                  ],
                ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.changeThemeMode();
          },
          child: Obx(() => Icon(Icons.color_lens,
              color: controller.isDark.isTrue ? appPurpleDark : appWhite)),
        ));
  }
}
