class Team {

  String name;
  int placement;
  int kill;
  int get pointPlacement {

    int currentPoint = 0;

    switch (placement) {

      case 1:
      currentPoint += 300;
      break;

      case 2:
      currentPoint += 200;
      break;

      case 3:
      currentPoint += 170;
      break;

      case 4:
      currentPoint += 135;
      break;

      case 5:
      currentPoint += 105;
      break;

      case 6:
      currentPoint += 80;
      break;

      case 7:
      currentPoint += 60;
      break;

      case 8:
      currentPoint += 45;
      break;

      case 9:
      currentPoint += 30;
      break;

      case 10:
      currentPoint += 20;
      break;

      case 11:
      currentPoint += 10;
      break;

      case 12:
      currentPoint += 0;
      break;

      case 13:
      currentPoint += 0;
      break;

      default:
      currentPoint += 0;
      break;
    }

    return currentPoint;
  }
  int get pointKill => kill * 20;
  int get totalPoint => pointPlacement + pointKill;

  Team({this.name, this.placement, this.kill});
}