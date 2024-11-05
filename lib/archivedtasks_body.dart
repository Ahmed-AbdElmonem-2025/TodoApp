import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/cubit/states.dart';

import 'cubit/cubit.dart';
import 'widgets/task_item.dart';
 

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TodoCubit>(context);
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return ListView.separated(
        itemBuilder: (context,index)=>buildTaskItem(cubit.archivedTasks[index],context) , 
        separatorBuilder: (context,index)=>Container(
         width: double.infinity,
         height: 1,
         color: Colors.grey,
        ) , 
        itemCount: cubit.archivedTasks.length);
   } );
       
       
  }
}