import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/order.dart';
import 'package:flutter_tutorial/screens/OrderAddScreen.dart';
import 'package:flutter_tutorial/utils/OrdersUtils.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen(this.order);

  final Order order;

  @override
  _OrderDetailsScreenScreenState createState() {
    print('view outside');
    OrderUtils.viewOrder(order);
    return new _OrderDetailsScreenScreenState(order);
  }
}

class _OrderDetailsScreenScreenState extends State<OrderDetailsScreen> {
  _OrderDetailsScreenScreenState(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Заказ"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 16),
                child: Text(
                  order.title,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87),
                )),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                "от " + order.cost.toString() + " ₽",
                style: TextStyle(fontSize: 16, color: Colors.pink),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 16),
                child: Text(
                  order.description,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey),
                )),
            Container(
                margin: const EdgeInsets.only(top: 12, right: 12),
                child: Image(
                  image: NetworkImage(order.image),
                )),
            Container(
              margin: const EdgeInsets.only(top: 8, right: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat("kk:mm dd.MM.yyyy").format(order.pubDate).toString(),
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.visibility, color: Colors.grey),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          order.viewsCount.toString() + " просмотров",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => launch("tel:${order.telephone}"),
        child: Icon(Icons.call),
      ),
    );
  }

}
