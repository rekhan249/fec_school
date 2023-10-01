// ignore_for_file: unused_element
import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/events_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EventsProvider {
  Future<List<Event>> getUsers() async {
    List<Event> eventsList = [];
    try {
      var url = Uri.parse(event);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer zZT5D4MvFApZYy8fJZFbBEutfecgqB24CfDq5pbu',
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        var jsonRespose = json.decode(response.body);
        Events events = Events.fromMap(jsonRespose);
        eventsList.addAll(events.data);
        if (jsonRespose['status']) {
          Fluttertoast.showToast(
              msg: '${jsonRespose['status']} Working Successfully');
        } else {
          Fluttertoast.showToast(msg: ' Error is something wrong');
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return eventsList;
  }
}
