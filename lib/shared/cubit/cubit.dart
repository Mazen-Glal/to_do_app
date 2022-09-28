import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:to_do/modules/done_tasks/done_tasks_screen.dart';
import 'package:to_do/modules/new_tasks/new_tasks_screen.dart';
import 'package:to_do/shared/cubit/states.dart';
import 'package:flutter/material.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitState());
  static AppCubit get(context)=> BlocProvider.of(context);
  late Database database;
  int currentIndex = 0;
  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archivedTasks =[];
  IconData buttonIcon = Icons.add ;
  bool isBottomSheetShown = false;
  List<Widget> screens = [const NewTasksScreen(), const DoneTasksScreen(), const ArchivedTasksScreen()];
  List<String> titles= ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void onChangeBottomSheetItem(int index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          debugPrint('Database created..');
          database
              .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            debugPrint('Table created...');
          }).catchError((error) {
            debugPrint('Error when create the table : ${error.toString()}');
          });
        }, onOpen: (database) {
          debugPrint('Database opened..');
          getDataFromDatabase(database);
        }).then((value) {
          database=value;
          emit(CreateDBState());
    });
  }

  void deleteDataFromDB({required int id}) {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DeleteDBState());
      debugPrint('record number $id is deleted...');
      getDataFromDatabase(database);
    });
  }

  insertToDatabase({required String title,required String time, required String date}) async {
     await database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        debugPrint('record number $value inserted successfully');
        emit(InsertDBState());
        getDataFromDatabase(database);
      }).catchError((error) {
        debugPrint('Error when insert the row : ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(Database database) {
    newTasks =[];
    doneTasks =[];
    archivedTasks =[];
   database.rawQuery('SELECT * FROM tasks').then((value) {
     for (var element in value) {
       if(element['status']=='new') {
         newTasks.add(element);
       }else if(element['status']=='done')
       {
         doneTasks.add(element);
       }
       else{
         archivedTasks.add(element);
       }
     }
     emit(GetDBState());
    });
  }

  void changeFActionButton({required bool bottomSheetShown,required IconData icon}) {
    isBottomSheetShown = bottomSheetShown;
    buttonIcon = icon ;
    emit(ChangeFloatingAction());
  }

  void updateDatabase({required String status,required int id}) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status,  id]).then((value) {
         emit(UpdateDBState());
         debugPrint('record number $id is updated...');
         getDataFromDatabase(database);
    });
  }
}
