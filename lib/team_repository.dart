import 'package:ff_point_count/team_model.dart';

class TeamRepository {

  List<Team> _currentData = [];

  List<Team> get getListTeam {

    return _currentData.isNotEmpty ? _currentData : defaultData();
  }

  void postPlacement(int position, int place) {

    Team selectTM = _currentData[position];
    selectTM.placement = place;
    updateData(position, selectTM);
  }

  void incementKill(int position) {

    Team selectTM = _currentData[position];
    selectTM.kill++;
    updateData(position, selectTM);
  }

  void decrementKill(int position) {

    Team selectTM = _currentData[position];
    selectTM.kill--;
    updateData(position, selectTM);
  }

  void updateData(int position, Team selectTM) {

    _currentData[position] = selectTM;
  }

  List<Team> defaultData() => [

    Team(
      name: 'taawd',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'ww',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'hwad',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'kfaw',
      placement: 0,
      kill: 0
    ),
  ];
}