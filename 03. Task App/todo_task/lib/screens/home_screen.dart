import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_task/data/complete_database.dart';
import 'package:todo_task/data/ongoing_database.dart';
import 'package:todo_task/utils/task_tile.dart';

import '../utils/dialog_box.dart';

class HomeScreen extends StatefulWidget {
  final String? name;
  const HomeScreen({
    super.key,
    this.name,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // refrence the hive box;
  final _myBoxOngoing = Hive.box('myBoxOngoing');
  TaskDataBaseOngoing dbo = TaskDataBaseOngoing();

  final _myBoxComplete = Hive.box('myBoxComplete');
  TaskDataBaseComplete dbc = TaskDataBaseComplete();

  @override
  void initState() {
    if (_myBoxOngoing.get('ONGOING') == null) {
      dbo.createInitialDataOngoing();
    } else {
      dbo.loadDataOngoing();
    }
    if (_myBoxComplete.get('COMPLETE') == null) {
      dbc.createInitialDataComplete();
    } else {
      dbc.loadDataComplete();
    }

    super.initState();
  }

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _dateController = TextEditingController();

  void checkBoxChangedOngoing(bool? value, int index) {
    setState(() {
      dbo.ongoing[index][3] = !dbo.ongoing[index][3];
      if (dbo.ongoing[index][3] == true) {
        dbc.complete.add([
          dbo.ongoing[index][0],
          dbo.ongoing[index][1],
          dbo.ongoing[index][2],
          true,
        ]);
        dbo.ongoing.removeAt(index);
      }
    });
    dbo.updateDataBaseOngoing();
    dbc.updateDataBaseComplete();
  }

  void checkBoxChangedComplete(bool? value, int index) {
    setState(() {
      dbc.complete[index][3] = !dbc.complete[index][3];
      if (dbc.complete[index][3] == false) {
        dbo.ongoing.add([
          dbc.complete[index][0],
          dbc.complete[index][1],
          dbc.complete[index][2],
          false,
        ]);
        dbc.complete.removeAt(index);
      }
    });
    dbc.updateDataBaseComplete();
    dbo.updateDataBaseOngoing();
  }

  // cancel new task
  void cancelNewTask() {
    _titleController.clear();
    _contentController.clear();
    _dateController.clear();

    Navigator.of(context).pop();
  }

  // save new task
  void saveNewTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plese fill all Title!!')));
    } else {
      setState(() {
        dbo.ongoing.add([
          _titleController.text,
          _contentController.text,
          _dateController.text,
          false,
        ]);
      });
      _titleController.clear();
      _contentController.clear();
      _dateController.clear();
      Navigator.of(context).pop();
      dbo.updateDataBaseOngoing();
    }
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titleController: _titleController,
          contentController: _contentController,
          dateController: _dateController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void taskUpdate(int index) {
    _titleController.text = dbo.ongoing[index][0];
    _contentController.text = dbo.ongoing[index][1];
    _dateController.text = dbo.ongoing[index][2];
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titleController: _titleController,
          contentController: _contentController,
          dateController: _dateController,
          onSave: () => saveExistingTask(index),
          onCancel: () => cancelNewTask(),
        );
      },
    );
  }

  void saveExistingTask(int index) {
    setState(() {
      dbo.ongoing[index][0] = _titleController.text;
      dbo.ongoing[index][1] = _contentController.text;
      dbo.ongoing[index][2] = _dateController.text;
    });
    _titleController.clear();
    _contentController.clear();
    _dateController.clear();
    Navigator.pop(context);
    dbo.updateDataBaseOngoing();
  }

  // delete task
  void deleteTaskOngoing(int index) {
    setState(() {
      dbo.ongoing.removeAt(index);
    });
    dbo.updateDataBaseOngoing();
  }

  void deleteTaskComplete(int index) {
    setState(() {
      dbc.complete.removeAt(index);
    });
    dbc.updateDataBaseComplete();
  }

  @override
  Widget build(BuildContext context) {
    int cnto = dbo.ongoing.length;
    int cntc = dbc.complete.length;
    double progress = 0;
    var oper = 0;
    var cper = 0;
    if (cntc + cnto != 0) {
      progress = cntc / (cnto + cntc);
    }
    if (cntc != 0 || cnto != 0) {
      oper = (cnto / (cnto + cntc) * 100).round();
      cper = (cntc / (cnto + cntc) * 100).round();
    }

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange.shade200,
        elevation: 0,
        toolbarHeight: 50,
        // title: const Text(
        //   'Task App',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 24,
        //   ),
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lightbulb_circle),
                Icon(Icons.lightbulb_circle),
                Icon(Icons.lightbulb_circle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lightbulb_circle),
                Icon(Icons.lightbulb_circle),
                Icon(Icons.lightbulb_circle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lightbulb_circle),
                Icon(Icons.lightbulb_circle),
                Icon(Icons.lightbulb_circle),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.orange.shade200,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  $cntc task completed ($cper%)',
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '  $cnto task pending ($oper%)',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 8.0,
                                backgroundColor: Colors.red,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.green)),
                            Center(
                              child: Text(
                                '${(progress * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            bottom: TabBar(
              indicatorColor: Colors.orange,
              labelColor: Colors.orange.shade900,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(
                  text: 'Ongoing Task',
                ),
                Tab(
                  text: 'Completed Task',
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orange.shade100,
                  Colors.orange.shade50,
                ],
              ),
            ),
            child: TabBarView(
              children: [
                // Content of Tab 1
                Center(
                  child: (cnto > 0)
                      ? ListView.builder(
                          itemCount: dbo.ongoing.length,
                          itemBuilder: (context, index) {
                            return TaskTile(
                                taskTitle: dbo.ongoing[index][0],
                                taskContent: dbo.ongoing[index][1],
                                taskTime: dbo.ongoing[index][2],
                                taskCompleted: dbo.ongoing[index][3],
                                onChanged: (value) =>
                                    checkBoxChangedOngoing(value, index),
                                deleteTask: (context) =>
                                    deleteTaskOngoing(index),
                                updateTask: (context) => taskUpdate(index));
                          })
                      : const Center(
                          child: Text("No Task Yet"),
                        ),
                ),
                // Content of Tab 2
                Center(
                  child: (cntc > 0)
                      ? ListView.builder(
                          itemCount: dbc.complete.length,
                          itemBuilder: (context, index) {
                            return TaskTile(
                              taskTitle: dbc.complete[index][0],
                              taskContent: dbc.complete[index][1],
                              taskTime: dbc.complete[index][2],
                              taskCompleted: dbc.complete[index][3],
                              onChanged: (value) =>
                                  checkBoxChangedComplete(value, index),
                              deleteTask: (context) =>
                                  deleteTaskComplete(index),
                              updateTask: (context) => taskUpdate(index),
                            );
                          })
                      : const Center(
                          child: Text("No Task Yet"),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          createNewTask();
        },
        backgroundColor: Colors.amber.shade900,
        label: const Text('Add New Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
