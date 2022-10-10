import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/provider.dart';
import 'add_student_provider.dart';
import 'update_student_provider.dart';

class HomePageProvider extends ConsumerStatefulWidget {
  const HomePageProvider({super.key});

  @override
  HomePageProviderState createState() => HomePageProviderState();
}

class HomePageProviderState extends ConsumerState<HomePageProvider> {
  String filterName = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UUID wih Provider'),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(localStorageProvider).deleteAllStudent();
              setState(() {});
            },
            icon: const Icon(Icons.delete_outline),
          ),
          PopupMenuButton(
              icon: const Icon(Icons.filter_list),
              onSelected: (value) {
                if (value == 'Default') {
                  filterName = 'Default';
                  setState(() {});
                } else if (value == 'Name by Accending') {
                  filterName = 'Name by Accending';
                  setState(() {});
                } else if (value == 'Name by Decending') {
                  filterName = 'Name by Decending';
                  setState(() {});
                } else if (value == 'Age over 20') {
                  filterName = 'Age over 20';
                  setState(() {});
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: "Default",
                    child: Text("Default"),
                  ),
                  const PopupMenuItem(
                    value: "Name by Accending",
                    child: Text("Name by Accending"),
                  ),
                  const PopupMenuItem(
                    value: "Name by Decending",
                    child: Text("Name by Decending"),
                  ),
                  const PopupMenuItem(
                    value: "Age over 20",
                    child: Text("Age over 20"),
                  ),
                ];
              })
        ],
      ),
      body: FutureBuilder(
        future: ref.read(localStorageProvider).getAllStudent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var studentList = snapshot.data;

            // soft list with object
            if (filterName == 'Name by Accending') {
              studentList?.sort(
                (a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                },
              );
            } else if (filterName == 'Name by Decending') {
              studentList?.sort(
                (a, b) {
                  return b.name.toLowerCase().compareTo(a.name.toLowerCase());
                },
              );
            } else if (filterName == 'Age over 20') {
              studentList = studentList
                  ?.where((element) => int.parse(element.age) > 20)
                  .toList();
            }

            // print(studentList);
            return snapshot.data != null
                ? studentList!.isNotEmpty
                    ? ListView.builder(
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              Get.to(UpdateStudentPageProvider(
                                      studentModel: studentList![index]))
                                  ?.then((value) async {
                                await ref
                                    .read(localStorageProvider)
                                    .getAllStudent();
                                setState(() {});
                              });
                            },
                            onLongPress: () async {
                              await ref
                                  .read(localStorageProvider)
                                  .deleteStudent(studentList![index].id);
                              await ref
                                  .read(localStorageProvider)
                                  .getAllStudent();
                              setState(() {});
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(studentList![index].name),
                                    Text(
                                        '${studentList[index].age}/ ${studentList[index].phone}'),
                                    Text(studentList[index].date),
                                    Text(studentList[index].id),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('Empty Data in List'),
                      )
                : const Center(
                    child: Text('Not Data in List'),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddStudentPageProvider())!.then((value) async {
            await ref.read(localStorageProvider).getAllStudent();
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
