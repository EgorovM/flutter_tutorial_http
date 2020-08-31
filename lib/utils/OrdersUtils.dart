import 'dart:convert';

import 'package:http/http.dart';

import '../models/order.dart';

class OrderUtils {

  static final String _baseUrl = "http://192.168.0.4:8000/";

  //CREATE
  static Future<Response> addOrder(Order order) async{

    String apiUrl = _baseUrl + "add_order";

    Response response = await post(apiUrl,
      body: order.toJson(),
    ).catchError((error) => print(error));
    
    print(jsonEncode(order));
    return response;
  }

  static Future viewOrder(order) async{
    String apiUrl = _baseUrl + "view_order";

    Response response = await post(apiUrl,
      body: {"id": order.id.toString()},
    );

    return response;
  }

  static Future getOrdersList() async{

    String apiUrl = _baseUrl + "get_orders";

    Response response = await get(apiUrl);

    return response;
  }
}