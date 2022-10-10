import 'package:flutter_sembast/sembast_with_state_notifier_provider/database/student_model_state_notifier.dart';
import 'package:sembast/sembast.dart';

import '../../sembast_with_provider/database/sembast_database_provider.dart';

// CRUD Function
class LocalStorageServiceWithState {
  SembastDatabase sembastDatabase;
  LocalStorageServiceWithState(this.sembastDatabase);

  Future<void> addStudent(StudentModelWithState studentModel) async {
    print('Add student');
    final localStore = stringMapStoreFactory.store('state');
    localStore
        .record(studentModel.id)
        .put(sembastDatabase.database, studentModel.toMap());
  }

  Future<List<StudentModelWithState>> getAllStudent() async {
    print('Get all students');
    final localStore = stringMapStoreFactory.store('state');
    var record = await localStore.find(
      sembastDatabase.database,
    );
    List<StudentModelWithState> modelList = [];
    for (var i = 0; i < record.length; i++) {
      modelList.add(StudentModelWithState.fromMap(record[i].value));
    }
    print(modelList);
    return modelList;
  }

  Future<void> updateStudent(StudentModelWithState studentModel) async {
    final localStore = stringMapStoreFactory.store('state');
    localStore.update(
      sembastDatabase.database,
      studentModel.toMap(),
      finder: Finder(
        filter: Filter.custom(
          (record) => record.key == studentModel.id,
        ),
      ),
    );
    // localStore.record(studentModelId.phone).put(database, studentModelId.toMap());
    print('Update student');
  }

  Future<void> deleteStudent(String id) async {
    final localStore = stringMapStoreFactory.store('state');
    localStore.delete(
      sembastDatabase.database,
      finder: Finder(
        filter: Filter.custom(
          (record) => record.value['id'] == id,
        ),
      ),
    );
    print('Delete student');
  }

  Future<void> deleteAllStudent() async {
    final localStore = stringMapStoreFactory.store('state');
    localStore.delete(sembastDatabase.database);
    print('Delete all students');
  }

  // filter, not use now
  // Future<List<StudentModelProvider>> getAllStudentByNameAccending() async {
  //   database = await createDatabase();
  //   print('Get all students');
  //   createDatabase();
  //   final localStore = stringMapStoreFactory.store('id');
  //   var record = await localStore.find(
  //     database,
  //   );
  //   List<StudentModelProvider> modelList = [];
  //   for (var i = 0; i < record.length; i++) {
  //     modelList.add(StudentModelProvider.fromMap(record[i].value));
  //   }
  //   modelList.sort(
  //     (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
  //   );
  //   return modelList;
  // }
  // Future<List<StudentModelProvider>> getAllStudentByNameDecending() async {
  //   database = await createDatabase();
  //   print('Get all students');
  //   createDatabase();
  //   final localStore = stringMapStoreFactory.store('id');
  //   var record = await localStore.find(
  //     database,
  //   );
  //   List<StudentModelProvider> modelList = [];
  //   for (var i = 0; i < record.length; i++) {
  //     modelList.add(StudentModelProvider.fromMap(record[i].value));
  //   }
  //   modelList.sort(
  //     (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
  //   );
  //   return modelList;
  // }
  // Future<List<StudentModelProvider>> getAllStudentAgeOver20() async {
  //   database = await createDatabase();
  //   print('Get all students, Age over 20');
  //   createDatabase();
  //   final localStore = stringMapStoreFactory.store('id');
  //   var record = await localStore.find(
  //     database,
  //   );
  //   List<StudentModelProvider> modelList = [];
  //   for (var i = 0; i < record.length; i++) {
  //     modelList.add(StudentModelProvider.fromMap(record[i].value));
  //   }
  //   var over20List =
  //       modelList.where((element) => int.parse(element.age) > 20).toList();
  //   // modelList.takeWhile((value) => int.parse(value.age) > 22).toList(); // Cannot use over ( > 20)
  //   // print(over20List);
  //   // print(modelList);
  //   return over20List;
  // }
}
