import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_database/database/sembast_database.dart';
import 'package:flutter_sembast/sembast_database/database/student_model.dart';
import 'package:get/get.dart';

class UpdateStudentPage extends StatefulWidget {
  final StudentModel studentModel;
  const UpdateStudentPage({super.key, required this.studentModel});

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  LocalStorage localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    nameController.text = widget.studentModel.name;
    ageController.text = widget.studentModel.age;
    phoneController.text = widget.studentModel.phone;
  }

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
                readOnly: true,
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
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  print('Update Click');
                  log('${nameController.text}/ ${ageController.text}/ ${phoneController.text}');
                  if (formKey.currentState!.validate()) {
                    log('${nameController.text}/ ${ageController.text}/ ${phoneController.text}');
                    var student = StudentModel(nameController.text,
                        ageController.text, phoneController.text);
                    localStorage
                        .updateStudent(student)
                        .then((value) => localStorage.getAllStudent());
                  }
                  Get.back();
                },
                icon: const Icon(Icons.save),
                label: const Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
