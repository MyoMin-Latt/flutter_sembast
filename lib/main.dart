import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_with_phone/pages/home_page_ph.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GetMaterialApp(
    home: MyApp(),
    title: 'NoSQL Sembast',
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sembast Database'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(const HomePage());
              },
              child: const Text('Sembast with phone'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('data'),
            )
          ],
        ),
      ),
    );
  }
}
