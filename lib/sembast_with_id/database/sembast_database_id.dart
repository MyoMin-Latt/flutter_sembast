// ignore: depend_on_referenced_packages
import 'package:flutter_sembast/sembast_with_id/database/student_model_id.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uuid/uuid.dart';

// Create Sembast Database (NoSQL)
// class SembastDatabase {
//   late Database database;
//   SembastDatabase() {
//     createDatabase();
//   }

//   Future<void> createDatabase() async {
//     final dbDir = await getApplicationDocumentsDirectory();
//     final dbPath = path.join(dbDir.path, 'sembast.db');
//     database = await databaseFactoryIo.openDatabase(dbPath);
//   }
// }

// CRUD Function
class LocalStorageId {
  late Database database;
  var uuid = const Uuid();
  LocalStorageId();
  Future<Database> createDatabase() async {
    final dbDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(dbDir.path, 'sembastid.db');
    database = await databaseFactoryIo.openDatabase(dbPath);
    print('create database');
    return database;
  }

  Future<void> addStudent(StudentModelId studentModelId) async {
    database = await createDatabase();
    final localStore = stringMapStoreFactory.store('id');
    localStore.record(studentModelId.id).put(database, studentModelId.toMap());
    print('Add student');
  }

  // TODO: now cannot, need to try
  // Stream getStudents() {
  //   final localStore = stringMapStoreFactory.store('id');
  //   return localStore.stream(sembastDatabase.database);
  //   List<StudentModelId> valueList = [];
  //   for (var i = 0; i < localData.length; i++) {
  //     valueList.add(StudentModelId.fromMap(localData[i].value));
  //   }
  //   print(valueList);
  // }

  Future<List<StudentModelId>> getAllStudent() async {
    database = await createDatabase();
    print('Get all students');
    createDatabase();
    final localStore = stringMapStoreFactory.store('id');
    var record = await localStore.find(
      database,
      // finder: Finder(
      //   filter: Filter.custom(
      //     (record) => record.value['phone'].toString().contains(''),
      //   ),
      // ),
    );
    List<StudentModelId> modelList = [];
    for (var i = 0; i < record.length; i++) {
      modelList.add(StudentModelId.fromMap(record[i].value));
    }
    return modelList;

    // List<String> record3 = await localStore.findKeys(sembastDatabase.database);
    // List<Map<String, Object?>?> recordList = [];
    // for (var i = 0; i < record3.length; i++) {
    //   var data =
    //       await localStore.record(record3[i]).get(sembastDatabase.database);
    //   recordList.add(data);
    // }
    // print('Third Record FindKeys : $record3');
    // print('Third Record Record lenth : $recordList');
    // Third Record : [09001, 09002]
  }

  Future<void> updateStudent(StudentModelId studentModelId) async {
    database = await createDatabase();
    final localStore = stringMapStoreFactory.store('id');
    localStore.update(
      database,
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
    database = await createDatabase();
    final localStore = stringMapStoreFactory.store('id');
    localStore.delete(
      database,
      finder: Finder(
        filter: Filter.custom(
          (record) => record.value['id'] == id,
        ),
      ),
    );
    print('Delete student');
  }

  Future<void> deleteAllStudent() async {
    database = await createDatabase();
    final localStore = stringMapStoreFactory.store('id');
    localStore.delete(database);
    print('Delete all students');
  }
}
