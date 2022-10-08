import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_with_id/database/sembast_database_id.dart';
import 'package:flutter_sembast/sembast_with_id/pages/add_student_id.dart';
import 'package:flutter_sembast/sembast_with_id/pages/update_student_id.dart';
import 'package:get/get.dart';

class HomePageId extends StatefulWidget {
  const HomePageId({super.key});

  @override
  State<HomePageId> createState() => _HomePageIdState();
}

class _HomePageIdState extends State<HomePageId> {
  LocalStorageId localStorage = LocalStorageId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database With Id'),
        actions: [
          IconButton(
            onPressed: () {
              localStorage.deleteAllStudent();
              setState(() {});
            },
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      body: FutureBuilder(
        future: localStorage.getAllStudent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var studentList = snapshot.data;

            // soft list with object
            studentList?.sort(
              (a, b) {
                return a.age.toLowerCase().compareTo(b.age.toLowerCase());
              },
            );
            print(studentList);
            return snapshot.data != null
                ? snapshot.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: studentList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(UpdateStudentPageId(
                                      studentModel: studentList[index]))
                                  ?.then((value) async {
                                await localStorage.getAllStudent();
                                setState(() {});
                              });
                            },
                            onLongPress: () async {
                              await localStorage
                                  .deleteStudent(studentList[index].id);
                              await localStorage.getAllStudent();
                              setState(() {});
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(studentList[index].name),
                                    Text(
                                        '${studentList[index].age}/ ${studentList[index].phone}'),
                                    Text(studentList[index].date),
                                    Text(studentList[index].id),
                                  ],
                                ),
                              ),
                            ),
                          );
                          //     // onTap: () => Get.to(UpdateStudentPageId(
                          //     //         studentModel: studentList[index]))!
                          //     //     .then((value) async {
                          //     //   await localStorage.getAllStudent();
                          //     //   setState(() {});
                          //     // }),
                          //   ),
                          // );
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
          Get.to(const AddStudentPageId())!.then((value) async {
            print('Back to Home from add student');
            print('Back value : $value');
            await localStorage.getAllStudent();
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
