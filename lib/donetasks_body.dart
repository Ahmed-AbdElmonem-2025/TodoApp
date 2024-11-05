import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/task_item.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var cubit = BlocProvider.of<TodoCubit>(context);
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return ListView.separated(
        itemBuilder: (context,index)=>buildTaskItem(cubit.doneTasks[index],context) , 
        separatorBuilder: (context,index)=>Container(
         width: double.infinity,
         height: 1,
         color: Colors.grey,
        ) , 
        itemCount: cubit.doneTasks.length);
   } );
       
       
  }
}