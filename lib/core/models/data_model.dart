enum Issue {
  vaccine,
  oxygen,
  hospital,
  plasma,
}

class DataModel {
  Issue issue;
  String title;
  String disc;
  String details;
  String location;
  String locationURL;
  String datetime;

  DataModel({
    this.issue,
    this.title,
    this.disc,
    this.location,
    this.locationURL,
  });

  DataModel.fromJSON(Issue thisIssue, List<dynamic> l) {
    issue = thisIssue;
    title = l[0];
    disc = l[1] ?? '';
    location = l[2];
    locationURL = l[3];
    details = l[4] ?? '';
    datetime = l[5] ?? ' ';
  }
}
