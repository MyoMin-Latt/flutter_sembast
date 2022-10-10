import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_with_id/pages/home_page_id.dart';
import 'package:flutter_sembast/sembast_with_phone/pages/home_page_ph.dart';
import 'package:flutter_sembast/sembast_with_provider/pages/home_page_provider.dart';
import 'package:flutter_sembast/sembast_with_provider/provider/provider.dart';
import 'package:flutter_sembast/sembast_with_state_notifier_provider/pages/home_page_state_notifier.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: GetMaterialApp(
      home: MyApp(),
      title: 'NoSQL Sembast',
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (previous, next) {});
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
              child: const Text('Id with phone'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const HomePageId());
              },
              child: const Text('Id with uuid'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const HomePageProvider());
              },
              child: const Text('UUID with provider'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const HomePageWithState());
              },
              child: const Text('UUID with stateNotifierProvider'),
            )
          ],
        ),
      ),
    );
  }
}
