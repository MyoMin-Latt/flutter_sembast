import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_database/pages/add_student.dart';
import 'package:get/get.dart';

import '../database/sembast_database.dart';
import '../database/student_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StudentModel> studentList = [];
  LocalStorage localStorage = LocalStorage();

  Future<void> getStudent() async {
    var list = await localStorage.getAllStudent();
    setState(() {
      studentList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sembast Database'),
        actions: [
          IconButton(
              onPressed: () {
                getStudent();
              },
              icon: const Icon(Icons.get_app))
        ],
      ),
      body: FutureBuilder(
        future: localStorage.getAllStudent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(studentList[index].name),
                    subtitle: Text(studentList[index].phone),
                    leading: Text(studentList[index].age),
                    trailing: IconButton(
                        onPressed: () {
                          localStorage.deleteStudent(studentList[index].phone);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete_forever)),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddStudentPage())?.then((value) => getStudent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
