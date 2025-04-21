import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrsaleh_project/Control/taskContorl.dart';
import 'package:mrsaleh_project/Model/taskModel.dart';
import 'package:mrsaleh_project/View/Screen/AllTasks.dart';
import 'package:mrsaleh_project/View/Screen/CompleteTasks.dart';
import 'package:mrsaleh_project/View/Screen/NotComplete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  taskControl tc = taskControl();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  TextEditingController taskController = TextEditingController();
  Future<void> addImageFromGallery() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (selectedImage != null) {
        _image = File(selectedImage.path);
      }
    });
  }

  Future<void> addImageFromCamera() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (selectedImage != null) {
        _image = File(selectedImage.path);
      }
    });
  }

  void showOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose the Photo"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: addImageFromCamera,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    )),
                SizedBox(),
                IconButton(
                    onPressed: addImageFromGallery,
                    icon: Icon(
                      Icons.photo,
                      color: Colors.black,
                    ))
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Color.fromARGB(255, 3, 129, 106),
            child: Column(children: [
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: showOption,
                child: CircleAvatar(
                  // backgroundColor: Colors.amber,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage("image/images.png") as ImageProvider,
                  radius: 90,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 8,
                        left: 15,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromARGB(255, 3, 129, 106),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            bottom: TabBar(
              splashBorderRadius: BorderRadius.zero,
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Text(
                    "All",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    " Done",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    "not done",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AllTask(),
              CompleteTask(),
              notComplete(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Add Task"),
                    content: TextFormField(
                      controller: taskController,
                      decoration: InputDecoration(
                        hintText: "Enter Task",
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            tc.addTask(taskModel(
                                status: false, title: taskController.text));
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Add"),
                      )
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Color.fromARGB(255, 3, 129, 106),
          ),
        ));
  }
}
