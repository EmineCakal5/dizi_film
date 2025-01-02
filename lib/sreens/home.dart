import 'package:der_3/constants/colors.dart';
import 'package:der_3/constants/tasktype.dart';
import 'package:der_3/helpers/database_helper.dart';
import 'package:der_3/model/task.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'add_new_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> towatch = [];
  List<Task> watched = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _dbHelper.getMovies();
    setState(() {
      towatch = tasks.where((task) => !task.isCompleted).toList();
      watched = tasks.where((task) => task.isCompleted).toList();
    });
  }

  Future<void> addNewTask(Task newTask) async {
    await _dbHelper.addMovie(newTask);
    _loadTasks();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _dbHelper.updateMovie(task);
    _loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await _dbHelper.deleteMovie(task.id!);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              // Header
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
                    ),
                  ],
                ),
              ),

              // "To Watch" List
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: towatch.length,
                    itemBuilder: (context, index) {
                      final task = towatch[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  task.type == TaskType.tv
                                      ? "lib/assets/images/tv.png"
                                      : "lib/assets/images/Movie.png",
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    task.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  value: task.isCompleted,
                                  onChanged: (value) {
                                    toggleTaskCompletion(task);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    deleteTask(task);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "IMDb: ${task.rate}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              task.description,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Watched List Header
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

              // "Watched" List
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: watched.length,
                    itemBuilder: (context, index) {
                      final task = watched[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  task.type == TaskType.tv
                                      ? "lib/assets/images/tv.png"
                                      : "lib/assets/images/Movie.png",
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    task.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  value: task.isCompleted,
                                  onChanged: (value) {
                                    toggleTaskCompletion(task);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    deleteTask(task);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "IMDb: ${task.rate}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              task.description,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Add New Task Button
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddNewTaskScreen(
                        addNewTask: addNewTask,
                      ),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor(secondaryColor),
                    shadowColor: HexColor(secondaryColor),
                    foregroundColor: Colors.white,
                  ),
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
