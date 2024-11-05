 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/archivedtasks_body.dart';
import 'package:p/cubit/states.dart';
import 'package:p/donetasks_body.dart';
import 'package:p/newtasks_body.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class TodoCubit extends Cubit<TodoStates> {
  
  TodoCubit() : super(InitState());
  
 static TodoCubit get(context) => BlocProvider.of(context);

   List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
   ]; 

   List<String> titls = [
    'news tasks',
    'done tasks',
    'archived tasks',
   ]; 
   
   int currentindex = 0;

  void changeCurrentIndex(int index){
     currentindex = index;
    emit(ChangeCurrentIndexState());
   }
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
      version: 2,
      // onCreate بتتنفذ لما قاعدة البيانات لسه جديدة وبتتعمل لأول مرة.
      onCreate: (db, version) {
        db.execute('CREATE TABLE tasks ('
          'id INTEGER PRIMARY KEY, '
          'title TEXT, '
          'time TEXT, '
          'date TEXT, '
          'status TEXT'
          ')');
      },
      onOpen: (db) {
        print('open database');
        getdatafromdatabase();
      },

       
    );
  }

  // دالة إدخال بيانات باستخدام rawInsert
  Future<void> inserttodb(
    {
      required String title,
      required String time,
      required String date,
        String status="new",
    }
  ) async {
    emit(InsertLoadingState());
    await database.transaction((txn) async {
      txn
          .rawInsert('INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","$status")')
          .then((value) { // id row
        print("gooooooooooooooood");
        emit(InsertSuccessState());
         getdatafromdatabase();
      }).catchError((e) {
        print("eror");
        emit(InsertErrorState());
      });
    });
  }




  Future<void>updatdb(
    {
    required String status,
    required int id,
    }
  ) async {
    await database.transaction((txn) async {
      txn
          .rawUpdate('UPDATE tasks SET status=? WHERE id = ?',
          [status,id],
          )
          .then((value) { // id row
          emit(UpdateSuccessState());
          getdatafromdatabase();
        print("id $value created");
      }).catchError((e) {
        print("erooooooooooooorrrrrrrrr");
         emit(UpdateErrorState());
      });
    });
  }





 deletefromdb({required int id})async {

 await database.rawDelete(
  'DELETE FROM tasks WHERE id = ?',
  [id],
 ).then((value){

  emit(DeleteSucessState());
  getdatafromdatabase();
 }).catchError((e) {
  print("eroorrr");
  emit(DeleteErrorState());  // اضف هذه السطر لإصدار حالة خطأ
});

 }


 

// record -> employee 1 , employee 2 , employee 3  كل واحدة فيهم روو وهى دى الليست اللى بترجعها
// والماب اللى هى اول عنصر فى الليست وتانى عنصر وهكذا وبتكون سترينج ودايناميك
  List<Map<String, dynamic?>> newTasks=[] ;
  List<Map<String, dynamic?>> doneTasks=[] ;
  List<Map<String, dynamic?>> archivedTasks=[] ;
   void getdatafromdatabase() async {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    //emit(GetRecordLoadingState());
    return await database.rawQuery('SELECT * FROM tasks')
    .then((value){ // value return => List<Map<String, Object?>>
  for (var row in value) {
    if (row['status'] == 'new') {
      newTasks.add(row);
    } else if(row['status'] == 'done') {
      doneTasks.add(row);
    }else{
      archivedTasks.add(row);
    }
  }
   emit(GetRecordSuccessState());
   print(value.toString());
    });
  }






 // حذف قاعدة البيانات القديمة
Future<void> deleteOldDatabase() async {
 
  await deleteDatabase(join(await getDatabasesPath(), 'todo.db'));
}




   bool isBottomSheetShown =false;
   IconData fabicon = Icons.edit;
   void changeBottomSheet(
    {required bool ishow , required IconData icon }
   ){

    isBottomSheetShown = ishow;
         fabicon =icon;

         emit(ChangeBottomSheetState());

   }





}