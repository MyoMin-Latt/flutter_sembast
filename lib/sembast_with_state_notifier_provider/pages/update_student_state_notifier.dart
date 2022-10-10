import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sembast/sembast_with_state_notifier_provider/database/student_model_state_notifier.dart';
import 'package:flutter_sembast/sembast_with_state_notifier_provider/state_notifier_provider/provider.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateStudentPageWithState extends ConsumerStatefulWidget {
  final StudentModelWithState studentModel;
  const UpdateStudentPageWithState({super.key, required this.studentModel});

  @override
  UpdateStudentPageProviderState createState() =>
      UpdateStudentPageProviderState();
}

class UpdateStudentPageProviderState
    extends ConsumerState<UpdateStudentPageWithState> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    nameController.text = widget.studentModel.name;
    ageController.text = widget.studentModel.age;
    phoneController.text = widget.studentModel.phone;
    dateController.text = widget.studentModel.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update student'),
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
              TextFormField(
                controller: dateController,
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
                  // log('${nameController.text}/ ${ageController.text}/ ${phoneController.text}');
                  if (formKey.currentState!.validate()) {
                    log('${nameController.text}/ ${ageController.text}/ ${phoneController.text}');
                    var student = StudentModelWithState(
                        widget.studentModel.id,
                        nameController.text,
                        ageController.text,
                        phoneController.text,
                        dateController.text);
                    ref.read(localServiceProvider).updateStudent(student);
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
