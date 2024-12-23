import 'package:der_3/constants/tasktype.dart';
import 'package:der_3/model/task.dart';
import 'package:flutter/material.dart';

class ToWatchItem extends StatefulWidget {
  const ToWatchItem({super.key, required this.task});
  final Task task;

  @override
  State<ToWatchItem> createState() => _ToWatchItemState();
}

class _ToWatchItemState extends State<ToWatchItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isCompleted ? Colors.white70 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.task.type == TaskType.movie
                ? Image.asset("lib/assets/images/Movie.png")
                : Image.asset("lib/assets/images/tv.png"),
            
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal:10),
                   child: Column(
                    children: [
                      Text(
                        widget.task.title,
                        style:  TextStyle(
                          decoration: widget.task.isCompleted ? TextDecoration.lineThrough :TextDecoration.none,
                            fontWeight: FontWeight.bold,
                             fontSize: 21),
                      ),
                      Text(
                        widget.task.description,
                        style: TextStyle(
                          decoration: widget.task.isCompleted 
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                        ),),
                    ],
                                 ),
                 ),
               ),
             Checkbox(
          value: isChecked,
          onChanged: (val) => {
            setState(
              () {
                widget.task.isCompleted = !widget.task.isCompleted;
                isChecked = val!;
              },
            ),
          },
        ),
          ],
        ),
       
      ),
    );
  }
}
