enum ActionType { control, view }

class Permission {
  //The permission
  String permVal;
  //What is
  String affectedService;
  //What action
  ActionType actionType;
}
