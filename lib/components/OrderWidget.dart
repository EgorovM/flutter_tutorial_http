import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/order.dart';
import 'package:flutter_tutorial/screens/OrderDetailsScreen.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(order.title),
      subtitle: Text(DateFormat("kk:mm dd.MM.yyyy").format(order.pubDate)),
      leading: Icon(Icons.work, size: 30),
      trailing: IconButton(
          icon: Icon(Icons.phone, size: 24),
          onPressed: () => launch("tel:${order.telephone}"),
      ),
      onTap: () => Navigator.of(context)
          .push(new MaterialPageRoute(
          builder: (_) => new OrderDetailsScreen(order))),
    );
  }
}
