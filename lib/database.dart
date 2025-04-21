
import 'package:mrsaleh_project/Model/taskModel.dart';

class dataBase {
  static final db = dataBase();
  List<taskModel> tasks = [
    taskModel(status: true, title: "play football"),
    taskModel(status: false, title: "training"),
    taskModel(status: true, title: "study"),
    taskModel(status: true, title: "work"),
    taskModel(status: true, title: "eat"),
    taskModel(status: true, title: "sleep  "),
    taskModel(status: true, title: "drive"),
    taskModel(status: false, title: "color"),
    taskModel(status: true, title: "steatch"),
    taskModel(status: true, title: "sleep"),
    taskModel(status: true, title: "swim"),
    taskModel(status: true, title: "pray"),
  ];
}
