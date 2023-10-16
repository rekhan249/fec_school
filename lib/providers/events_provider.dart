// ignore_for_file: unused_element, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/events_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventsProvider {
  Future<List<Event>> getUsers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    List<Event> eventsList = [];
    try {
      var url = Uri.parse(event);
      var response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer 28|bnVOtJBd29J9DkvFmoRcOSFIjjMmoZsbF7dHxpEK501cb173',
          "Content-Type": "application/json",
          "Accept": 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        },
      );

      print('111111111111111111111111111${response.body.toString()}');
      var jsonRespose = json.decode(response.body);
      print('event status code${response.statusCode}');
      if (response.statusCode == 200) {
        Events events = Events.fromMap(jsonRespose);
        eventsList.addAll(events.data);
        if (jsonRespose['status']) {
          Fluttertoast.showToast(
              msg: '${jsonRespose['status']} Working Successfully');
        } else {
          Fluttertoast.showToast(msg: 'Error is something wrong');
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return eventsList;
  }
}
