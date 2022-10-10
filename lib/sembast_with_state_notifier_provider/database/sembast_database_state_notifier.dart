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
    // print(modelList);
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

  Future<List<StudentModelWithState>> getAllStudentByNameAccending() async {
    print('get All Student ByName Accending');
    final localStore = stringMapStoreFactory.store('state');
    var record = await localStore.find(sembastDatabase.database);
    List<StudentModelWithState> modelList = [];
    for (var i = 0; i < record.length; i++) {
      modelList.add(StudentModelWithState.fromMap(record[i].value));
    }
    modelList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return modelList;
  }

  Future<List<StudentModelWithState>> getAllStudentByNameDecending() async {
    print('get All Student ByName Decending ');
    final localStore = stringMapStoreFactory.store('state');
    var record = await localStore.find(sembastDatabase.database);
    List<StudentModelWithState> modelList = [];
    for (var i = 0; i < record.length; i++) {
      modelList.add(StudentModelWithState.fromMap(record[i].value));
    }
    modelList
        .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    return modelList;
  }

  Future<List<StudentModelWithState>> getAllStudentAgeOver20() async {
    print('Get all students, Age over 20');
    final localStore = stringMapStoreFactory.store('state');
    var record = await localStore.find(sembastDatabase.database);
    List<StudentModelWithState> modelList = [];
    for (var i = 0; i < record.length; i++) {
      modelList.add(StudentModelWithState.fromMap(record[i].value));
    }
    var over20List =
        modelList.where((element) => int.parse(element.age) > 20).toList();
    return over20List;
  }
}
