import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast/pages/add_student.dart';
import 'package:flutter_sembast/sembast/pages/update_student.dart';
import 'package:get/get.dart';

import '../database/sembast_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database With Phone'),
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
            print(studentList);
            return snapshot.data != null
                ? snapshot.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: studentList!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(studentList[index].name),
                              subtitle: Text(studentList[index].phone),
                              leading: Text(studentList[index].age),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await localStorage.deleteStudent(
                                        studentList[index].phone);
                                    await localStorage.getAllStudent();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete_forever)),
                              onTap: () => Get.to(UpdateStudentPage(
                                      studentModel: studentList[index]))!
                                  .then((value) async {
                                await localStorage.getAllStudent();
                                setState(() {});
                              }),
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
          Get.to(const AddStudentPage())!.then((value) async {
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
