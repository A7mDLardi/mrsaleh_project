import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mrsaleh_project/Control/taskContorl.dart';
import 'package:mrsaleh_project/Model/taskModel.dart';
import 'package:mrsaleh_project/database.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({super.key});

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  taskControl tc = taskControl();
  TextEditingController editText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final allTask =
        dataBase.db.tasks.where((element) => element.status == true).toList();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: allTask.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (ctx) => {
                      setState(() {
                        tc.deletTask(allTask[index]);
                      })
                    },
                    icon: Icons.delete,
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.transparent,
                  )
                ]),
                startActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (ctx) => {
                      editText.text = allTask[index].title,
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("update Task"),
                            content: TextFormField(
                              controller: editText,
                              decoration: InputDecoration(
                                hintText: "Enter new Task",
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    tc.editTask(
                                        index,
                                        taskModel(
                                            status: allTask[index].status,
                                            title: editText.text));
                                    print(index);
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text("Update"),
                              )
                            ],
                          );
                        },
                      )
                    },
                    icon: Icons.edit,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                ]),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 129, 106),
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    trailing: Icon(
                      Icons.animation_outlined,
                      color: Colors.white,
                    ),
                    leading: Checkbox(
                      value: allTask[index].status,
                      onChanged: (value) {
                        setState(() {
                          tc.updateStatusTask(taskModel(
                              status: false, title: allTask[index].title));
                        });
                      },
                      checkColor: Colors.black,
                      fillColor: MaterialStateProperty.all(Colors.grey[400]),
                    ),
                    title: Text(
                      "${allTask[index].title}",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: allTask[index].status == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Colors.black,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
