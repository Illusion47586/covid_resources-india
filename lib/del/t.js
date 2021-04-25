function returnFalse(info) {
  return ContentService.createTextOutput(
    JSON.stringify({ status: false, reason: info })
  ).setMimeType(ContentService.MimeType.JSON);
}

function doGet(e) {
  var stateSheet = SpreadsheetApp.openById(
    "1T5kSK1sdsXPHPqdpucIyA6-oBBm2ySILIAYYPX7DgYc"
  ).getSheetByName(e.parameters["state"]);

  if (stateSheet == null) return returnFalse("State not in database");

  var cityColumn = stateSheet.getSheetValues(2, 1, stateSheet.getMaxRows(), 1);

  var myCityColumnIndexStart = cityColumn.findIndex(
    (value, index, obj) => value[0] == e.parameters["city"]
  );

  if (myCityColumnIndexStart == -1)
    return returnFalse("City / District not in database");

  var myCityColumnIndexEnd = cityColumn.findIndex(
    (value, index, obj) =>
      value[0] != e.parameters["city"] && index > myCityColumnIndexStart
  );

  console.log(myCityColumnIndexStart);
  console.log(myCityColumnIndexEnd);

  var issueColumn = stateSheet.getSheetValues(
    myCityColumnIndexStart + 2,
    2,
    myCityColumnIndexEnd - myCityColumnIndexStart + 1,
    1
  );

  console.log(issueColumn);

  var myIssueColumnIndexStart = issueColumn.findIndex(
    (value, index, obj) => value[0] == e.parameters["issue"]
  );

  if (myCityColumnIndexStart == -1)
    return returnFalse("Info about this is not in database");

  var myIssueColumnIndexEnd = issueColumn.findIndex(
    (value, index, obj) =>
      (value[0] != e.parameters["issue"] && index > myIssueColumnIndexStart) ||
      index == obj.length - 1
  );

  if (myIssueColumnIndexEnd == -1) myIssueColumnIndexEnd = myCityColumnIndexEnd;

  console.log(myIssueColumnIndexStart);
  console.log(myIssueColumnIndexEnd);

  var resultValues = stateSheet.getSheetValues(
    myIssueColumnIndexStart + myCityColumnIndexStart + 2,
    3,
    myIssueColumnIndexEnd - myIssueColumnIndexStart,
    6
  );

  var res = {
    status: true,
    length: resultValues.length,
    values: resultValues,
  };

  console.log(resultValues);

  return ContentService.createTextOutput(JSON.stringify(res)).setMimeType(
    ContentService.MimeType.JSON
  );
}
