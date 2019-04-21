abstract class TeamEvent {

  final int position;

  TeamEvent(this.position);
}

class PostPlacement extends TeamEvent {
  int selectPlacement;
  PostPlacement(int position, {this.selectPlacement}) : super(position);
}

class IncrementKill extends TeamEvent {
  IncrementKill(int position) : super(position);
}

class DecrementKill extends TeamEvent {
  DecrementKill(int position) : super(position);
}

class ResetProgress extends TeamEvent {
  ResetProgress(int position) : super(position);
}