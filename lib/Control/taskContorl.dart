
import 'package:mrsaleh_project/Model/taskModel.dart';
import 'package:mrsaleh_project/database.dart';

class taskControl {
  void addTask(taskModel task) {
    dataBase.db.tasks.add(task);
  }

  void deletTask(taskModel task) {
    dataBase.db.tasks.remove(task);
  }

  void updateStatusTask(taskModel updatedTask) {
    for (int i = 0; i < dataBase.db.tasks.length; i++) {
      if (dataBase.db.tasks[i].title == updatedTask.title) {
        dataBase.db.tasks[i] = updatedTask;
        break;
      }
    }
  }

  void editTask(int index, taskModel updatedTask) {
    if (index >= 0 && index < dataBase.db.tasks.length) {
      dataBase.db.tasks[index] = updatedTask;
    }
  }
}
