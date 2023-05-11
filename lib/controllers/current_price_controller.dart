// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter_test_btc_display/models/current_price_btc_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentPriceController extends GetxController {
  var currentPriceBTC = CurrentPriceBtcModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    updateDataEveryMinute(); // เรียกใช้ฟังก์ชันอัปเดตทุกๆ 1 นาที
  }

  void fetchData() async {
  var url = Uri.https('api.coindesk.com', '/v1/bpi/currentprice.json');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body); // ใช้ jsonDecode แทน json.decode
    currentPriceBTC.value = CurrentPriceBtcModel.fromJson(data);
  } else {
    // กรณีเกิดข้อผิดพลาดในการเรียก API
    print('เกิดข้อผิดพลาดในการเรียก API');
  }
}

  void updateDataEveryMinute() {
    Future.delayed(Duration(minutes: 1), () {
      fetchData();
      updateDataEveryMinute();
    });
  }
}
