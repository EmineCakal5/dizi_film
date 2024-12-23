import 'package:der_3/constants/colors.dart';
import 'package:der_3/constants/tasktype.dart';
import 'package:der_3/model/task.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key,required this.addNewTask});
  final void Function(Task newTask) addNewTask;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController imdbController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TaskType taskType = TaskType.note;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight / 10,
                color: HexColor(primaryColor),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(child: Text("Add New Show",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 19,
                     color:Colors.white) )),
                  ],
                ),
              ),
              const Padding(
                padding:  EdgeInsets.only(top:15.0),
                child:  Text("New Show",
                style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20),
                            ),
              ),
               Padding(
                padding: const EdgeInsets.all(10.0),
                child:  TextField(
                  controller: titleController ,
                  decoration:const InputDecoration(filled: true,fillColor: Colors.white) 
                  ,
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(top:8.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    const Text("Category",
                    style: TextStyle(fontSize:20, 
                    fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 300),
                        content: Text("Category Selected"),),
                    );
                    setState(() {
                      taskType = TaskType.movie;
                    });
                      },
                      child: Image.asset("lib/assets/images/Movie.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 300),
                        content: Text("Category Selected"),),
                    );
                     setState(() {
                      taskType = TaskType.tv;
                    });
                      },
                      child: Image.asset("lib/assets/images/tv.png"),
                    ),                
                  ],
                               ),
               ),
              Padding(
                padding:const EdgeInsets.only(top:8.0),
                child:  Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                           const Text("Imdb", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding:const EdgeInsets.symmetric(horizontal:10 ),
                            child: TextField(
                              controller: imdbController,
                              decoration: const InputDecoration(filled: true, fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                     Expanded(
                      child: Column(
                        children: [
                          const Text("Time", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: timeController,
                              decoration: const InputDecoration(filled: true, fillColor: Colors.white),
                            ),
                            
                          ),
                        ],
                      ),
                    ),                
                  ],
                ),
              ),
             const Padding(
                padding:  EdgeInsets.only(top:8.0),
                child:  Text("Description",style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child:  SizedBox(
                  height: 300,
                  
                  child: TextField(
                    controller: descriptionController,
                    expands: true,maxLines: null,
                        decoration: const InputDecoration(filled: true, fillColor: Colors.white, isDense: true),
                        ),
                        ),
                      
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ElevatedButton(onPressed: () {
                  Task newTask =Task(type: taskType,
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: false,
                  );
                  widget.addNewTask(newTask);
                  Navigator.pop(context);
                }, 
                style:ElevatedButton.styleFrom(
                  shadowColor: HexColor(primaryColor),
                  foregroundColor: Colors.white,
                  backgroundColor: HexColor(secondaryColor)
                ),
                child: const Text("Save")),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
