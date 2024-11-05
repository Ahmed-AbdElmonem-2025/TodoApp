import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/cubit/cubit.dart';
import 'package:p/cubit/states.dart';
import 'package:p/sqldb.dart';
import 'package:p/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      
      create: (BuildContext context) { 
        return TodoCubit()..initialdb(); 
        },
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home:   TodoScreen(),
      ),
    );
  }
}
 

