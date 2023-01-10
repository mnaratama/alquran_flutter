import 'package:alquran/app/constants/color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: box.read("themeDark") == null ? appLight : appDark,
      title: "Application",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
