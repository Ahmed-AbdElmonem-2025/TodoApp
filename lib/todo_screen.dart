
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:p/cubit/cubit.dart';
import 'package:p/cubit/states.dart';
import 'package:p/widgets/text_form.dart';
 

class TodoScreen extends StatelessWidget {
     TodoScreen({ Key? key }) : super(key: key);
 
   var scaffoldKey = GlobalKey<ScaffoldState>();
   var formKey = GlobalKey<FormState>();
   var titleController = TextEditingController();
   var timeController = TextEditingController();
   var DateController = TextEditingController();
  
  
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<TodoCubit>(context);
        return   Scaffold(
          key: scaffoldKey,
          appBar: AppBar(title: Text(TodoCubit.get(context).titls[TodoCubit.get(context).currentindex],),),
           
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: TodoCubit.get(context).currentindex ,
          onTap: (index) {
            TodoCubit.get(context).changeCurrentIndex(index);
          },
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu) ,label: 'tasks', ),
          BottomNavigationBarItem(icon: Icon(Icons.check_box) ,label: 'Done', ),
          BottomNavigationBarItem(icon: Icon(Icons.archive) ,label: 'archived', ),
        ]),

        body: state is GetRecordLoadingState ?  Center(child: CircularProgressIndicator()) : TodoCubit.get(context).screens[TodoCubit.get(context).currentindex],

        floatingActionButton: FloatingActionButton(
          child: Icon(cubit.fabicon),
          onPressed: () {
            if (cubit.isBottomSheetShown) {

              if (formKey.currentState!.validate()) {
                cubit.inserttodb(title: titleController.text, time: timeController.text,date: DateController.text);
                Navigator.pop(context);
              cubit.changeBottomSheet(ishow: false, icon: Icons.edit);
              }
              
            } else {
               scaffoldKey.currentState!.showBottomSheet((context) => 
                Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textFieldItem(Controller: titleController, hintText: 'title'),
                          SizedBox(height: 15,),
                          textFieldItem(Controller: timeController, hintText: 'Time',
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now()
                        ).then((value){
                             timeController.text = value!.format(context).toString();
                        });
                    },
                    ),
                    SizedBox(height: 15,),
                       textFieldItem(Controller: DateController, hintText: 'DateTime',
                    onTap: () {
                      showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate:  DateTime.now(), 
                        
                        lastDate: DateTime.parse('2024-10-21'),
                        ).then((value){
                          if (value != null) {
                        DateController.text = DateFormat.yMMMd().format(value);
                          }
                           
                        });
                    },
                    ),
                      ],
                    ),
                  ),
                  
                  
                ],
               ),
           ).closed.then((value) {
            /////////////////////
             
                
              cubit.changeBottomSheet(ishow: false, icon: Icons.edit);
           });
              cubit.changeBottomSheet(ishow: true, icon: Icons.add);
            }
          
        },),
         
       );
      },
       
     );
   }

   
 }