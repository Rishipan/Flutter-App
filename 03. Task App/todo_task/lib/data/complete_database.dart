import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class TaskDataBaseComplete {
  List complete = [];

  final _myBoxComplete = Hive.box('myBoxComplete');

  void createInitialDataComplete() {
    complete = [
      [
        'Manual:-',
        '-Slide me left to edit\n-Slide me left to delete\n-When task completed\nthen you can check me ✅',
        '🫡',
        true
      ]
    ];
  }

  void loadDataComplete() {
    complete = _myBoxComplete.get('COMPLETE');
  }

  void updateDataBaseComplete() {
    _myBoxComplete.put('COMPLETE', complete);
  }
}
