/*import 'package:p/cubit/states.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqldb {
  // هنخزن هنا قاعدة البيانات اللى هننشئها او نفتحها
  late Database database;

//الدالة دي بتفتح أو تنشئ قاعدة البيانات وبتاخد وقت
  Future<void> initialdb() async {
    // الباث اللى هخزن فيه الداتا
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo.db');
    // هنا بنقول للتطبيق: "افتحلي قاعدة بيانات". كلمة await معناها "استنى لحد ما
    // تفتح قاعدة البيانات". زي لما تقول لحد "افتح الدرج
    //واستنى لحد ما يفتح عشان تشوف اللي جواه".

    database = await openDatabase(
      path,
      version: 1,
      // onCreate بتتنفذ لما قاعدة البيانات لسه جديدة وبتتعمل لأول مرة.
      onCreate: (db, version) {
        db.execute('create TABLE tasks (id INTEGER PRIMARY KEY , title TEXT)');
      },
      
    );
  }

  // دالة إدخال بيانات باستخدام rawInsert
  Future<void> inserttodb(
    {
      required String title,
    
    }
  ) async {
    emit(InsertLoadingState());
    await database.transaction((txn) async {
      txn
          .rawInsert('INSERT INTO tasks(title) VALUES($title)')
          .then((value) { // id row
        print("gooooooooooooooood");
      }).catchError((e) {
        print("erooooooooooooorrrrrrrrr");
      });
    });
  }




  Future<void>updatdb(
    {
      required String title,
    required int id,
    }
  ) async {
    await database.transaction((txn) async {
      txn
          .rawUpdate('UPDATE tasks SET title=? WHERE id = ?',
          [title,id],
          )
          .then((value) { // id row
        print("id $value created");
      }).catchError((e) {
        print("erooooooooooooorrrrrrrrr");
      });
    });
  }





 deletefromdb({required int id})async {

 await database.rawDelete(
  'DELETE FROM tasks WHERE id = ?',
  [id],
 );

 }





// record -> employee 1 , employee 2 , employee 3  كل واحدة فيهم روو وهى دى الليست اللى بترجعها
// والماب اللى هى اول عنصر فى الليست وتانى عنصر وهكذا وبتكون سترينج ودايناميك
late List<Map<String, dynamic?>> allTasks ;
   void getdatafromdatabase() async {
    return await database.rawQuery('SELECT * FROM tasks')
    .then((value){ // value return => List<Map<String, Object?>>
   print(value.toString());
    });
  }





}
*/