import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({
    Key? key,
    required this.taskName,
    required this.taskComplete,
    required this.onChanged,
    this.deleteFuntion,
  }) : super(key: key);

  final String taskName;
  final bool taskComplete;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFuntion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 30,
        bottom: 0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFuntion,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Checkbox(
                value: taskComplete,
                onChanged: onChanged,
                activeColor: Colors.deepPurple.shade900,
                checkColor: Colors.white,
                side: const BorderSide(color: Colors.black),
              ),
              Expanded(
                child: Text(
                  taskName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    decoration: taskComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.black,
                    decorationThickness: 3,
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
