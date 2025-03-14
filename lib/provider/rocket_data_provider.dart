import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rocketapp_assignment/model/rocket_model.dart';
import 'package:rocketapp_assignment/utils/constants.dart';
import 'package:rocketapp_assignment/utils/utils.dart';
import '../services/api_service.dart';
import 'package:http/http.dart' as http;

//this class created for manage app state using provider package
class RocketController extends ChangeNotifier {
  NetworkApiService network = NetworkApiService();
  bool isLoading = false;

  void loading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  List<RocketModel> rockets = [];

  Future<void> fetchRocket({required context}) async {
    isLoading = true;
    try {
      dynamic response = await network.getGetApiResponse(baseUrl);
      final List<dynamic> data = response;

      rockets = data.map((item) => RocketModel.fromJson(item)).toList();
      print(rockets[0].description);
      notifyListeners();
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      print("error $e");
    } finally {
      isLoading = false;
    }
  }

  RocketModel? detail;
  Future<void> fetchRocketDetails({
    String? id,
    required context,
  }) async {
    isLoading = true;
    try {
      dynamic response = await network.getGetApiResponse("${baseUrl}/$id");
      detail = detailModelFromJson(response);
      print(detail!.id.toString());
      notifyListeners();
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      print("error $e");
    } finally {
      isLoading = false;
    }
  }
}
