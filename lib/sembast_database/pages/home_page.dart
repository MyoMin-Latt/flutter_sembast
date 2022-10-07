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
  SembastDatabase sembastDatabase = SembastDatabase();

  List<StudentModel> studentList = [];

  Future<void> getStudent() async {
    LocalStorage localStorage = LocalStorage(sembastDatabase);
    studentList = await localStorage.getAllStudent();
    setState(() {});
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
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(studentList[index].name),
              subtitle: Text(studentList[index].phone),
              leading: Text(studentList[index].age),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.delete_forever)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddStudentPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
