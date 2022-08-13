// ignore_for_file: avoid_print, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataServices {
  String? from;
  String? to;
  DataServices({
    required this.from,
    required this.to,
  });

  Future getData() async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$from/$to?apikey=315C905A-5834-48EC-9589-1AB5892AF2A0';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
        print('Error fetching files from internet.');
      }
    } on Exception catch (_) {
      print('No internet connection');
      return null;
    }
  }
}

class ReusedCard extends StatelessWidget {
  ReusedCard({Key? key, required this.text}) : super(key: key);
  String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            text.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
