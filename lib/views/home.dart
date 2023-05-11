// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test_btc_display/controllers/current_price_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final CurrentPriceController controller = Get.put(CurrentPriceController());

  final btcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      appBar: AppBar(
        title:  Text(controller.currentPriceBTC.value.chartName.toString()),
      ),
      body: Obx(() => controller.currentPriceBTC.value.bpi == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 3, // จำนวนรายการที่จะแสดง (USD, GBP, EUR)
              itemBuilder: (context, index) {
                var currency;
                var value;

                switch (index) {
                  case 0:
                    currency = 'USD';
                    value = controller.currentPriceBTC.value.bpi!.usd.rate;
                    break;
                  case 1:
                    currency = 'GBP';
                    value = controller.currentPriceBTC.value.bpi!.gbp.rate;
                    break;
                  case 2:
                    currency = 'EUR';
                    value = controller.currentPriceBTC.value.bpi!.eur.rate;
                    break;
                }

                return ListTile(
                  title: Text(currency),
                  subtitle: Text(value),
                );
              },
            )),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       TextField(
      //         controller: btcController,
      //         keyboardType: TextInputType.number,
      //         decoration: const InputDecoration(
      //           labelText: 'BTC Amount',
      //         ),
      //       ),
      //       const SizedBox(height: 16.0),
      //       ElevatedButton(
      //         onPressed: () {
      //           String btcAmount = btcController.text;
      //           double btcValue = double.tryParse(btcAmount) ?? 0.0;

      //           double usdValue = btcValue *
      //               controller.currentPriceBTC.value.bpi!.usd.rateFloat;
      //           double gbpValue = btcValue *
      //               controller.currentPriceBTC.value.bpi!.gbp.rateFloat;
      //           double eurValue = btcValue *
      //               controller.currentPriceBTC.value.bpi!.eur.rateFloat;

      //           print('USD: $usdValue');
      //           print('GBP: $gbpValue');
      //           print('EUR: $eurValue');
      //         },
      //         child: const Text('Convert'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
