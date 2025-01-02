import 'package:flutter/material.dart';
import '../model/task.dart';
import '../constants/tasktype.dart';
import '../constants/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask});
  final void Function(Task newTask) addNewTask;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imdbController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TaskType? selectedCategory;

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
              // Header
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
                    const Expanded(
                      child: Text(
                        "Add New Show",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Title Input
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  "New Show",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Title",
                  ),
                ),
              ),

              // Category Selection
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    const Text(
                      "Category",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = TaskType.movie;
                            });
                          },
                          child: Image.asset(
                            "lib/assets/images/Movie.png",
                            height: 50,
                          ),
                        ),
                        const SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = TaskType.tv;
                            });
                          },
                          child: Image.asset(
                            "lib/assets/images/tv.png",
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // IMDb and Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Text(
                      "IMDb",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: imdbController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "IMDb Rating",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 150,
                  child: TextField(
                    controller: descriptionController,
                    expands: true,
                    maxLines: null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Description",
                    ),
                  ),
                ),
              ),

              // Save Button
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedCategory == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a category"),
                        ),
                      );
                      return;
                    }
                    final newTask = Task(
                      type: selectedCategory!,
                      title: titleController.text,
                      description: descriptionController.text,
                      rate: imdbController.text,
                    );
                    widget.addNewTask(newTask);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: HexColor(primaryColor),
                    foregroundColor: Colors.white,
                    backgroundColor: HexColor(secondaryColor),
                  ),
                  child: const Text("Save"),
                ),
              ),

              // Selected Category Text
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  selectedCategory == null
                      ? "No category selected"
                      : "Category Selected: ${selectedCategory == TaskType.movie ? "Movie" : "TV Show"}",
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedCategory == null
                        ? Colors.red
                        : HexColor(primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
