import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'recommendsys-babycare.herokuapp.com';

class RecommendRepository {
  static final http.Client httpClient = http.Client();

  static Future<String> getSampleStringData() async {
    final response = await httpClient.get(new Uri.http(baseUrl, ''));
    if (response.statusCode == 200) {
      final welcome = jsonDecode(response.body) as String;
      return welcome ?? '';
    } else {
      throw Exception('Something wrong');
    }
  }

  static Future<List> getSimilarProducts(String idProduct) async {
    final response = await httpClient.get(
        new Uri.http(baseUrl, 'similar_products', {'product_id': idProduct}));
    if (response.statusCode == 200) {
      final listProduct = jsonDecode(response.body) as List;
      return listProduct ?? [];
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List> getOutstandingProducts() async {
    final response =
        await httpClient.get(new Uri.http(baseUrl, 'product_recommend'));
    if (response.statusCode == 200) {
      final listProduct = jsonDecode(response.body) as List;
      return listProduct ?? [];
    } else {
      throw Exception(response.body);
    }
  }
}
