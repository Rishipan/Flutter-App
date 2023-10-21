import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class TaskDataBaseOngoing {
  List ongoing = [];

  final _myBoxOngoing = Hive.box('myBoxOngoing');

  void createInitialDataOngoing() {
    ongoing = [
      [
        'Manual:-',
        '-Slide me left to edit\n-Slide me left to delete\n-When task completed\nthen you can check me ✅',
        'Now',
        false
      ]
    ];
  }

  void loadDataOngoing() {
    ongoing = _myBoxOngoing.get('ONGOING');
  }

  void updateDataBaseOngoing() {
    _myBoxOngoing.put('ONGOING', ongoing);
  }
}
