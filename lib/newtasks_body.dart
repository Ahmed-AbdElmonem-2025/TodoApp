import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/cubit/cubit.dart';
import 'package:p/widgets/task_item.dart';

import 'cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
 var cubit = BlocProvider.of<TodoCubit>(context);
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return ListView.separated(
        itemBuilder: (context,index)=>buildTaskItem(cubit.newTasks[index],context) , 
        separatorBuilder: (context,index)=>Container(
         width: double.infinity,
         height: 1,
         color: Colors.grey,
        ) , 
        itemCount: cubit.newTasks.length);
   } );
       
       
  }
}