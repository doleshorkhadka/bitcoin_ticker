// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedValue = 'USD';
  List<dynamic> responseValue = [];
  List<String> coinValue = [];

  CupertinoPicker IOSpicker() {
    List<Widget> pickerItems = [];
    for (String item in kcurrenciesList) {
      pickerItems.add(Text(item));
    }
    return CupertinoPicker(
      diameterRatio: 1,
      magnification: 1.2,
      useMagnifier: true,
      itemExtent: 25.0,
      onSelectedItemChanged: (selectedIndex) {
        print(kcurrenciesList[selectedIndex]);
      },
      children: pickerItems,
    );
  }

  DropdownButton AndroidPicker() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String item in kcurrenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }
    return DropdownButton(
      value: selectedValue,
      items: dropDownItems,
      menuMaxHeight: 200,
      onChanged: (value) async {
        var rateValue = [];
        for (int i = 0; i < 3; i++) {
          responseValue.add(
              await DataServices(from: kcryptoList[i], to: value).getData());
          rateValue.add(responseValue[i]['rate']);
        }
        setState(() {
          responseValue = [];
          coinValue = [];
          selectedValue = value.toString();
          for (int i = 0; i < 3; i++) {
            rateValue.isEmpty
                ? coinValue.add('?')
                : coinValue.add(rateValue[i].toStringAsFixed(3));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReusedCard(
                  text:
                      '1 BTC = ${coinValue.isEmpty ? '?' : coinValue[0]} $selectedValue'),
              ReusedCard(
                  text:
                      '1 ETH = ${coinValue.isEmpty ? '?' : coinValue[1]} $selectedValue'),
              ReusedCard(
                  text:
                      '1 LTH = ${coinValue.isEmpty ? '?' : coinValue[2]} $selectedValue'),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Platform.isAndroid ? IOSpicker() : AndroidPicker(),
            ),
          ),
        ),
      ],
    );
  }

  SpinKitCubeGrid showSimpleDialogue(BuildContext context) {
    return SpinKitCubeGrid(color: Colors.blue);
  }
}
