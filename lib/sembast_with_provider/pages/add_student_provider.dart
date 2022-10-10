import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../database/student_model_provider.dart';
import '../provider/provider.dart';

class AddStudentPageProvider extends ConsumerStatefulWidget {
  const AddStudentPageProvider({super.key});

  @override
  AddStudentPageProviderState createState() => AddStudentPageProviderState();
}

class AddStudentPageProviderState
    extends ConsumerState<AddStudentPageProvider> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  var uuid = const Uuid();
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
                    // log('${nameController.text}/ ${ageController.text}/ ${phoneController.text}');
                    var student = StudentModelProvider(
                      uuid.v1(),
                      nameController.text,
                      ageController.text,
                      phoneController.text,
                      DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now()),
                    );
                    // print(student.toJson());
                    ref.read(localStorageProvider).addStudent(student);
                    // localStorage.addStudent(student);
                    Get.back();
                  }
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
