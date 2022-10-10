import 'package:flutter_sembast/sembast_with_id/database/student_model_id.dart';
import 'package:flutter_sembast/sembast_with_provider/database/student_model_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

// Create Sembast Database (NoSQL)
class SembastDatabase {
  late Database database;
  SembastDatabase();

  Future<void> createDatabase() async {
    final dbDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(dbDir.path, 'sembast.db');
    database = await databaseFactoryIo.openDatabase(dbPath);
  }
}

// CRUD Function
class LocalStorageService {
  SembastDatabase sembastDatabase;
  LocalStorageService(this.sembastDatabase);

  Future<void> addStudent(StudentModelProvider studentModel) async {
    print('Add student');
    final localStore = stringMapStoreFactory.store('ProviderWithID');
    localStore
        .record(studentModel.id)
        .put(sembastDatabase.database, studentModel.toMap());
  }

  Future<List<StudentModelProvider>> getAllStudent() async {
    print('Get all students');
    final localStore = stringMapStoreFactory.store('ProviderWithID');
    var record = await localStore.find(
      sembastDatabase.database,
    );
    List<StudentModelProvider> modelList = [];
    for (var i = 0; i < record.length; i++) {
      modelList.add(StudentModelProvider.fromMap(record[i].value));
    }
    return modelList;
  }

  Future<void> updateStudent(StudentModelProvider studentModelId) async {
    final localStore = stringMapStoreFactory.store('ProviderWithID');
    localStore.update(
      sembastDatabase.database,
      studentModelId.toMap(),
      finder: Finder(
        filter: Filter.custom(
          (record) => record.key == studentModelId.id,
        ),
      ),
    );
    // localStore.record(studentModelId.phone).put(database, studentModelId.toMap());
    print('Update student');
  }

  Future<void> deleteStudent(String id) async {
    final localStore = stringMapStoreFactory.store('ProviderWithID');
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
    final localStore = stringMapStoreFactory.store('ProviderWithID');
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
