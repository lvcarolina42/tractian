import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/shared/paths.dart';
import 'package:tractian/shared/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    initialRoute: Paths.menuPage,
    getPages: Routes.pages,
    debugShowCheckedModeBanner: false,
  ));
}
