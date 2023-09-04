import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_asignment_app/home_model.dart';
import 'package:get/get.dart';
import 'package:flutter_asignment_app/service/rest_service.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  Welcome? homeDataModel;
  List<RowData>? rowModelData = [];
  final itemList = <Item>[].obs;

  Future<void> getHomeDetails({bool isRefresh = false}) async {
    if (isRefresh) {
      isLoading = true.obs;
      update();
    }
    try {
      final response = await RestServices.instance.getRestCall();
      if (response != null && response.isNotEmpty) {
        homeDataModel = welcomeFromJson(response);
        if (homeDataModel != null) {
          rowModelData = homeDataModel!.rows;
          // for (int i = 0; i < rowModelData!.length; i++) {
          //   itemList.add(rowModelData![i].title as Item);
          // }
        }
      }
      if (isRefresh) isLoading = false.obs;

      refresh();
    } on SocketException catch (e) {
      logs('Catch exception in getHomeChallenges --> ${e.message}');
    }
  }

  void logs(String message) {
    print(message);
  }
}
