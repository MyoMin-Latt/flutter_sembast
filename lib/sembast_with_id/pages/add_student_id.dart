import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_with_id/database/student_model_id.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../database/sembast_database_id.dart';

class AddStudentPageId extends StatefulWidget {
  const AddStudentPageId({super.key});

  @override
  State<AddStudentPageId> createState() => _AddStudentPageIdState();
}

class _AddStudentPageIdState extends State<AddStudentPageId> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  LocalStorageId localStorage = LocalStorageId();
  var uuid = const Uuid();
  // Future<void> addStudent(StudentModel studentModel) async {
  //   await localStorage.addStudent(studentModel);
  // }

  // getStudent() {
  //   LocalStorage localStorage = LocalStorage();
  //   localStorage.getAllStudent();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  hintText: 'Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    log('${nameController.text}/ ${ageController.text}/ ${phoneController.text}');
                    var student = StudentModelId(
                      uuid.v1(),
                      nameController.text,
                      ageController.text,
                      phoneController.text,
                      DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now()),
                    );
                    localStorage.addStudent(student);
                  }
                  Get.back();
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
