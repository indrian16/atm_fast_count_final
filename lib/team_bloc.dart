import 'dart:async';
import 'package:ff_point_count/team_model.dart';
import 'package:ff_point_count/team_event.dart';

class TeamBloc {

  List<Team> _listTeam = [
    Team(
      name: 'AntiMukil•id Oleng Kapten',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Come Back',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Rude Boys',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Gokill•id',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'AntiMukil•id Hoa Hoe',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Etam•id 2',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Scandal•id Manyala',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Blue Flash Fighter',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Badak 9 Elite Squad',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Haus kill',
      placement: 0,
      kill: 0
    ),
    Team(
      name: "AkatsukiIDN ft'celcius",
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'AntiMukil•id Bar-Bar',
      placement: 0,
      kill: 0
    ),
  ];

  final _tmRepositoryStateController = StreamController<List<Team>>();
  final _tmRepositoryEventController = StreamController<TeamEvent>();

  StreamSink<List<Team>> get _inListTeam => _tmRepositoryStateController.sink;
  Stream<List<Team>> get listTeam => _tmRepositoryStateController.stream;

  List<Team> getDefaultData() => [

    Team(
      name: 'AntiMukil•id Oleng Kapten',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Come Back',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Rude Boys',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Gokill•id',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'AntiMukil•id Hoa Hoe',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Etam•id 2',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Scandal•id Manyala',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Blue Flash Fighter',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Badak 9 Elite Squad',
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'Haus kill',
      placement: 0,
      kill: 0
    ),
    Team(
      name: "AkatsukiIDN ft'celcius",
      placement: 0,
      kill: 0
    ),
    Team(
      name: 'AntiMukil•id Bar-Bar',
      placement: 0,
      kill: 0
    ),
  ];

  Sink<TeamEvent> get listTeamEventSink => _tmRepositoryEventController.sink;

  TeamBloc() {

    _tmRepositoryEventController.stream.listen(_mapEventToState);
  }

  List<Team> getResultMatch() {

    return _listTeam.toList();
  }

  void _mapEventToState(TeamEvent event) {

    if (event is PostPlacement) {

      _listTeam[event.position].placement = event.selectPlacement;
    }

    if (event is IncrementKill) {

      _listTeam[event.position].kill++;
    }

    if (event is DecrementKill) {

      if (_listTeam[event.position].kill > 0) {

        _listTeam[event.position].kill--;
      }
    }

    if (event is ResetProgress) {

      _listTeam = getDefaultData();
    }

    _inListTeam.add(_listTeam);
  }

  void dispose() {
    _tmRepositoryStateController.close();
    _tmRepositoryEventController.close();
  }
}