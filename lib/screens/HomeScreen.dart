import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/screens/OrderAddScreen.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_tutorial/components/OrderWidget.dart';
import 'package:flutter_tutorial/utils/OrdersUtils.dart';
import 'package:flutter_tutorial/models/order.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const ORDERS_URL = "http://192.168.0.4:8000/get_orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text("Нюрба.Работа")),
            body: new RefreshIndicator(
              child: FutureBuilder(
                future: getOrdersList(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List<Order> ordesList = snapshot.data;

                    return ListView.separated(
                      itemCount: ordesList.length,
                      itemBuilder: (_, index) => OrderWidget(ordesList[index]),
                      separatorBuilder: (_, __) => Divider(color: Colors.grey),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              onRefresh: handleRefresh,
            ),
            floatingActionButton: new FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (_) => new OrderAddScreen())),
            ));
  }

  Future<List<Order>> getOrdersList() async {
    List<Order> orderList = [];

    http.Response response = await OrderUtils.getOrdersList();
    print("parse start");

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var results = body["results"];

      for (var order in results) {
        print("order parsed");

        try {
          Order new_order = Order.fromJson(order["fields"]);
          new_order.id = order["pk"];

          orderList.add(new_order);
        } catch (error) {
          print(error);
        }
      }
    } else {
      //Handle error
    }
    print("parsed");

    return orderList;
  }

  Future<Null> handleRefresh() async {
    setState(() {});
  }
}
