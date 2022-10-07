import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_database/pages/home_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GetMaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
