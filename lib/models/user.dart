class Starter {
  final String uid;

  Starter({this.uid});
}

class CauseData {
  final String uid;
  String title;
  String description;
  String starter;
  final int target;
  int currentAmount;
  String email;
  final String searchID;
  String access;
  final String created;
  String notified;

  CauseData(
      {this.uid,
      this.title,
      this.description,
      this.starter,
      this.target,
      this.email,
      this.access,
      this.currentAmount,
      this.searchID,
      this.created,
      this.notified});
}
