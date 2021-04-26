import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:get/get.dart';

import '../../data/cities.dart';
import '../../data/states.dart';
import '../../helpers/request_helper.dart';
import '../../main.dart';
import '../models/data_model.dart';

class DataService extends GetxService {
  Rx<int> stateIndex = (-1).obs;
  Rx<int> cityIndex = (-1).obs;
  final Map<Issue, StreamController<List<DataModel>>> dataStream =
      <Issue, StreamController<List<DataModel>>>{};

  @override
  Future<void> onInit() async {
    for (var i in Issue.values) {
      dataStream[i] = StreamController<List<DataModel>>.broadcast();
      _autoRefresh(i);
    }
    getIndices();
    super.onInit();
  }

  void getIndices() {
    stateIndex.value = prefs.getInt('stateIndex') ?? -1;
    cityIndex.value = prefs.getInt('cityIndex') ?? -1;
  }

  Future<void> writeIndices(int stateIndex, int cityIndex) async {
    this.stateIndex.value = stateIndex;
    this.cityIndex.value = cityIndex;
    await prefs.setInt('stateIndex', stateIndex);
    await prefs.setInt('cityIndex', cityIndex);
  }

  void _autoRefresh(Issue thisIssue) {
    Timer.periodic(
      const Duration(minutes: 15),
      (timer) async {
        await requestData(thisIssue);
      },
    );
  }

  Future<void> requestData(Issue thisIssue) async {
    const String deployId =
        // ignore: lines_longer_than_80_chars
        'AKfycbwiFSsBlcMXfgLZRdmURrs-kBDHJNbQpcjTtX09_c6a1NdADjRcWtwN1HVO2z7BoG9qyw';

    final Uri uri = Uri(
      scheme: 'https',
      host: 'script.google.com',
      path: '/macros/s/$deployId/exec',
      queryParameters: {
        'state': stateList[stateIndex.value],
        'city': cities[stateIndex.value][cityIndex.value],
        'issue': EnumToString.convertToString(thisIssue),
      },
    );

    final data = await RequestHelper.getRequest(uri);

    print(data);

    if (data['status'] == false)
      dataStream[thisIssue].addError(data['reason']);
    else {
      if (data['values'][0][0].length > 0)
        setData(thisIssue, Map<String, dynamic>.from(data));
      else
        dataStream[thisIssue].addError('No info about this region.');
    }
  }

  String getCurrentLocation() {
    return cities[stateIndex.value][cityIndex.value] +
        '\n' +
        stateList[stateIndex.value];
  }

  bool setData(Issue thisIssue, Map<String, dynamic> map) {
    dataStream[thisIssue].add(List.generate(
      map['length'],
      (index) => DataModel.fromJSON(thisIssue, map['values'][index]),
    ));

    return true;
  }
}
