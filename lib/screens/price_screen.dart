import 'dart:io' show Platform;

import 'package:bitcoin_ticker_flutter/screens/components/custom_drop_down_button.dart';
import 'package:bitcoin_ticker_flutter/utilities/constants.dart';
import 'package:bitcoin_ticker_flutter/utilities/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  NetworkHelper networkHelper = NetworkHelper();
  String dropdownValue = kCurrenciesList[0];
  int selectedCurrency = 0;

  String btcRate = "1 BTC = ?";
  String ethRate = "1 ETH = ?";
  String ltcRate = "1 LTC = ?";

  String getPlatformDropdownValue() {
    if (Platform.isAndroid) return dropdownValue;
    return kCurrenciesList[selectedCurrency];
  }

  void setRates(double? bTCRate, double? eTHRate, double? lTCRate) {
    btcRate =
        "1 BTC = ${(bTCRate == null) ? "?" : bTCRate.round()} ${getPlatformDropdownValue()}";
    ethRate =
        "1 ETH = ${(eTHRate == null) ? "?" : eTHRate.round()} ${getPlatformDropdownValue()}";
    ltcRate =
        "1 LTC = ${(lTCRate == null) ? "?" : lTCRate.round()} ${getPlatformDropdownValue()}";
  }

  Container getAndroidDropdownPickerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: CustomDropDownButton(
          selectedCurrency: dropdownValue,
          onValueChanged: (String? value) {
            setState(() {
              if (value != null) {
                dropdownValue = value;
                getDataFromAPI();
              }
            });
          },
        ),
      ),
    );
  }

  CupertinoButton getiOSPickerButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _showDialog(
        CupertinoPicker(
          itemExtent: 32.0,
          squeeze: 1.2,
          magnification: 1.22,
          useMagnifier: true,
          scrollController: FixedExtentScrollController(
            initialItem: selectedCurrency,
          ),
          onSelectedItemChanged: (int selectedItem) {
            setState(() async {
              double rate = await networkHelper.getAssetData(
                  "BTC", kCurrenciesList[selectedCurrency]);
              selectedCurrency = selectedItem;
              btcRate = "1 BTC = $rate ${kCurrenciesList[selectedCurrency]}";
            });
          },
          children: kCurrenciesList.map((String itemValue) {
            return Center(
              child: Text(
                itemValue,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 75.0,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          child: Center(
            child: Text(
              kCurrenciesList[selectedCurrency],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: Colors.lightBlue,
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setRates(null, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🤑 Coin Ticker"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // BTC
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 28.0,
                    ),
                    child: Text(
                      btcRate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // ETH
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 28.0,
                    ),
                    child: Text(
                      ethRate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // LTC
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 28.0,
                    ),
                    child: Text(
                      ltcRate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            // padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isAndroid)
                ? getAndroidDropdownPickerButton()
                : getiOSPickerButton(),
          ),
        ],
      ),
    );
  }

  void getDataFromAPI() async {
    double btcRate =
        await networkHelper.getAssetData("BTC", getPlatformDropdownValue());
    double ethRate =
        await networkHelper.getAssetData("ETH", getPlatformDropdownValue());
    double ltcRate =
        await networkHelper.getAssetData("LTC", getPlatformDropdownValue());
    setState(() {
      setRates(btcRate, ethRate, ltcRate);
    });
  }
}
