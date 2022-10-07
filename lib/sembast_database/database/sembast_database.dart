// ignore: depend_on_referenced_packages
import 'package:flutter_sembast/sembast_database/database/student_model.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

// Create Sembast Database (NoSQL)
class SembastDatabase {
  late Database database;
  SembastDatabase() {
    createDatabase();
  }

  Future<void> createDatabase() async {
    final dbDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(dbDir.path, 'sembast.db');
    database = await databaseFactoryIo.openDatabase(dbPath);
  }
}

// CRUD Function
class LocalStorage {
  SembastDatabase sembastDatabase;
  LocalStorage(this.sembastDatabase);

  Future<void> addStudent(StudentModel studentModel) async {
    final localStore = stringMapStoreFactory.store('grade1');
    localStore
        .record(studentModel.phone)
        .put(sembastDatabase.database, studentModel.toMap());
  }

  // Stream getStudents() {
  //   final localStore = stringMapStoreFactory.store('grade1');
  //   return localStore.stream(sembastDatabase.database);
  //   List<StudentModel> valueList = [];
  //   for (var i = 0; i < localData.length; i++) {
  //     valueList.add(StudentModel.fromMap(localData[i].value));
  //   }
  //   print(valueList);
  // }

  Future<List<StudentModel>> getAllStudent() async {
    final localStore = stringMapStoreFactory.store('grade1');
    // var record1 =
    //     await localStore.record('09002').get(sembastDatabase.database);
    // print('First Record : $record1');
    // First Record : {name: b, age: 2, phone: 09002}
    // var record2 = await localStore.find(sembastDatabase.database,
    //     finder: Finder(filter: Filter.byKey('09001')));
    // print('Second Record : $record2');
    // Second Record : [Record(grade1, 09001) {name: a, age: 1, phone: 09001}]

    var record21 = await localStore.find(
      sembastDatabase.database,
      finder: Finder(
        filter: Filter.custom(
          (record) => record.value['phone'].toString().contains(''),
        ),
      ),
    );
    List<StudentModel> modelList = [];
    for (var i = 0; i < record21.length; i++) {
      modelList.add(StudentModel.fromMap(record21[i].value));
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
}