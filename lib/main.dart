import 'package:flutter/material.dart';
import 'package:ff_point_count/team_model.dart';
import 'package:ff_point_count/team_bloc.dart';
import 'package:ff_point_count/team_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final titleApp = 'ATM ID Fast Count';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titleApp,
      theme: ThemeData.light(),
      home: HomePage(title: titleApp),
      debugShowCheckedModeBanner: false,
      routes: {ResultMatchPage.routeName: (context) => ResultMatchPage()},
    );
  }
}

class HomePage extends StatefulWidget {
  final title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _bloc = TeamBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showDialogExit(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              onPressed: () => _showDialogReset(),
              icon: Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                List<Team> resultMatch = _bloc.getResultMatch();
                resultMatch
                    .sort((a, b) => b.totalPoint.compareTo(a.totalPoint));
                Navigator.of(context).pushNamed(ResultMatchPage.routeName,
                    arguments: resultMatch);
              },
              icon: Icon(Icons.keyboard_arrow_right),
            )
          ],
        ),
        body: StreamBuilder(
          stream: _bloc.listTeam,
          initialData: _bloc.getDefaultData(),
          builder: (ctx, snapshot) => _listViewTM(snapshot),
        ),
      ),
    );
  }

  TextStyle _titleStyle() =>
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  TextStyle _semiBigStyle() => TextStyle(
        fontSize: 18.0,
      );

  TextStyle _secondStyle() => TextStyle(
        fontSize: 16.0,
      );

  Widget _listViewTM(AsyncSnapshot<List<Team>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (ctx, pos) {
        return _cardTeam(snapshot.data[pos], pos);
      },
    );
  }

  Widget _cardTeam(Team team, int pos) {
    int _selectPlacement = team.placement;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(team.name, style: _titleStyle()),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Kill: ', style: _secondStyle()),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        child: Text('+'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () =>
                            _bloc.listTeamEventSink.add(IncrementKill(pos)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text('${team.kill}', style: _titleStyle()),
                      ),
                      MaterialButton(
                        child: Text('-'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () =>
                            _bloc.listTeamEventSink.add(DecrementKill(pos)),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Placement', style: _secondStyle()),
                  Row(
                    children: <Widget>[
                      DropdownButton(
                        value: _selectPlacement,
                        onChanged: (newValue) {
                          _bloc.listTeamEventSink.add(
                              PostPlacement(pos, selectPlacement: newValue));
                        },
                        items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
                            .map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text('$value', style: _titleStyle()),
                          );
                        }).toList(),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Placement P: ${team.pointPlacement}',
                      style: _semiBigStyle()),
                  Text('Kill P: ${team.pointKill}', style: _semiBigStyle())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Total Point: ${team.totalPoint}', style: _titleStyle())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _showDialogReset() {
    showDialog(
        context: (context),
        builder: (ctx) {
          return AlertDialog(
            title: Text('Reset Progress Count'),
            content: Text('Benehan awk endak mehapus hasil hitungan?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok Reset'),
                textColor: Colors.redAccent,
                onPressed: () {
                  _bloc.listTeamEventSink.add(ResetProgress(null));
                  Navigator.of(context).pop();
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Container(
                      height: 50.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Successfully Reset Progress Count'),
                        ],
                      ),
                    ),
                  ));
                },
              ),
              MaterialButton(
                child: Text('Cancel'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Future<bool> _showDialogExit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Keluar aplikasi?'),
        content: Text('Jika keluar maka semua data akan dihapus!'),
        actions: <Widget>[
          FlatButton(
            child: Text('Iya'),
            textColor: Colors.redAccent,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          MaterialButton(
            child: Text('Tidak'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(false),
          )
        ],
      )
    );
}

class ResultMatchPage extends StatelessWidget {
  static String routeName = '/result';

  @override
  Widget build(BuildContext context) {
    final List<Team> args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Result Match')),
      body: ListView.builder(
        itemCount: args.length,
        itemBuilder: (ctx, pos) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(args[pos].name, style: TextStyle(fontSize: 18.0)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Point: ${args[pos].totalPoint}',
                        style: TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
