import 'dart:convert';
import 'dart:developer';

import 'package:bitcoin_ticker_flutter/utilities/constants.dart';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper();

  Future<double> getAssetData(String asset, String currency) async {
    Uri uri = Uri.parse("$kBaseUrl/$asset/$currency?apiKey=$kApiKey");

    var response = await get(uri);
    log(response.body);

    dynamic rawJSON = jsonDecode(response.body);

    double rate = rawJSON["rate"];

    log("BTC Rate: $rate");

    return rate;
  }
}
