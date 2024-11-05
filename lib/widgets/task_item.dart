
 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/cubit/cubit.dart';
 

Widget buildTaskItem (Map model,BuildContext context){
  var cubit = BlocProvider.of<TodoCubit>(context);
 return  Dismissible(
  key: Key(model['id'].toString()),
   
   child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(model['time']),
              
            ),
            SizedBox(width: 10,),
                 Column(
                  mainAxisSize: MainAxisSize.min,
                  children:[
              Text(model['title'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              Text(model['date'],style: TextStyle(color:Colors.grey),),
                  ],
                 )
          
               ,  SizedBox(width: 10,),
                  IconButton(
                          onPressed: () {
                            cubit.updatdb(status: 'done', id: model['id']);
                          }, 
                          icon: Icon(Icons.check,color: Colors.green,)),
                         IconButton(
                          onPressed: () {
                            cubit.updatdb(status: 'archive', id: model['id']);
                          }, 
                          icon: Icon(Icons.archive,color: Colors.black38,)),
          ],
        ),
      ),
   onDismissed: (direction) {
     cubit.deletefromdb(id: model['id']);
   },
 );
}