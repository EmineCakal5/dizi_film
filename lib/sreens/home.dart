import 'package:der_3/constants/colors.dart';
import 'package:der_3/constants/tasktype.dart';
import 'package:der_3/model/task.dart';
import 'package:der_3/sreens/add_new_task.dart';
import 'package:der_3/towatchitem.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
//List<String> towatch = ["How I Met Your Mother","Inception"","Stranger Things","Seven","Succession"];
//  List<String> watched = ["Friends","Kung Fu Panda 3"];
List<Task> towatch = [
  Task(
      type: TaskType.tv,
      title: "How I Met Your Mother",
      description: "",
      isCompleted: false),

  Task(
      type: TaskType.movie,
      title:"Inception" ,
      description: "",
      isCompleted: false),

  Task(
      type: TaskType.tv,
      title: "Stranger Things",
      description: "",
      isCompleted: false),
  Task(
      type: TaskType.movie,
      title: "Seven",
      description: "",
      isCompleted: false),
  Task(
      type: TaskType.tv,
      title: "Succession",
      description: "",
      isCompleted: false),            

];
void addNewTask(Task newTask){
setState(() {
   towatch.add(newTask);
});
}
List<Task> watched = [
  Task(
      type: TaskType.tv,
      title: "Friends",
      description: "",
      isCompleted: true), 
  Task(
      type: TaskType.movie,
      title: "Kung Fu Panda 3",
      description: "",
      isCompleted: true),         
];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            //Header
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight / 3,
                color: HexColor(primaryColor),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TO WATCH LIST",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              //Top Column
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: towatch.length,
                    itemBuilder: (context, index) {
                      return ToWatchItem(task: towatch[index]);
                    },
                  ),
                ),
              ),

              //Watched Text
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Watched",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              //Bottom Column
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: watched.length,
                    itemBuilder: (context, index) {
                      return ToWatchItem(task: watched[index]);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  AddNewTaskScreen(
                        addNewTask: (newTask) => addNewTask(newTask)  ,
                      ),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(secondaryColor),
                      shadowColor: HexColor(secondaryColor),
                      foregroundColor: Colors.white),
                  child: const Text("Add New Show"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
