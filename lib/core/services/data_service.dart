import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/cities.dart';
import '../../data/states.dart';
import '../../helpers/request_helper.dart';
import '../../views/screens/main_screen.dart';
import '../../views/screens/state_search_screen.dart';
import '../models/data_model.dart';

class DataService extends GetxService {
  int stateIndex;
  int cityIndex;
  final GetStorage box = GetStorage();
  final Map<Issue, StreamController<List<DataModel>>> dataStream =
      Map<Issue, StreamController<List<DataModel>>>();

  @override
  void onInit() {
    for (var i in Issue.values) {
      dataStream[i] = StreamController<List<DataModel>>.broadcast();
      _autoRefresh(i);
    }
    getIndices();
    handlerFunction();
    super.onInit();
  }

  void getIndices() {
    stateIndex = box.read('stateIndex');
    cityIndex = box.read('cityIndex');
  }

  Future<void> writeIndices(int stateIndex, int cityIndex) async {
    this.stateIndex = stateIndex;
    this.cityIndex = cityIndex;
    await box.write('stateIndex', stateIndex);
    await box.write('cityIndex', cityIndex);
  }

  void _autoRefresh(Issue thisIssue) {
    final Timer timer = Timer.periodic(
      Duration(minutes: 15),
      (timer) async {
        await requestData(thisIssue);
      },
    );
  }

  Future<void> requestData(Issue thisIssue) async {
    const String deployId =
        'AKfycbwiFSsBlcMXfgLZRdmURrs-kBDHJNbQpcjTtX09_c6a1NdADjRcWtwN1HVO2z7BoG9qyw';

    final Uri uri = Uri(
      scheme: 'https',
      host: 'script.google.com',
      path: '/macros/s/$deployId/exec',
      queryParameters: {
        'state': stateList[stateIndex],
        'city': cities[stateIndex][cityIndex],
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

  bool setData(Issue thisIssue, Map<String, dynamic> map) {
    dataStream[thisIssue].add(List.generate(
      map['length'],
      (index) => DataModel.fromJSON(thisIssue, map['values'][index]),
    ));

    return true;
  }

  void handlerFunction() {
    GetStorage().listenKey('cityIndex', (val) {
      if (val != null) {
        navigator.pop();
        navigator.pushReplacementNamed(MainScreen.id);
      } else {
        navigator.pushReplacementNamed(StateSearchScreen.id);
      }
    });
  }
}
