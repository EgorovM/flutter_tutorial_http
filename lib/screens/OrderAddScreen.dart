import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/order.dart';
import 'package:flutter_tutorial/utils/OrdersUtils.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class OrderAddScreen extends StatefulWidget {
  @override
  _OrderAddScreenState createState() => _OrderAddScreenState();
}

class _OrderAddScreenState extends State<OrderAddScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _title, _description, _telephone, _cost;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try{
        OrderUtils.addOrder(Order(
          image: "",
          title: _title,
          description: _description,
          telephone: _telephone,
          cost: int.parse(_cost),
          pubDate: DateTime.now(),
          viewsCount: 0,
        )).then((id) => Navigator.pop(context));
      }catch(error){
        print("error: " + error.toString());
      }
    }
  }

  final String phpEndPoint = 'http://192.168.43.171/phpAPI/image.php';
  final String nodeEndPoint = 'http://192.168.43.171:3000/image';
  File file;

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload() {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    post(phpEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Добавить заказ"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Container(
                child: new TextFormField(
                  decoration: new InputDecoration(labelText: "Заголовок"),
                  validator: (val) =>
                      val.isNotEmpty ? null : "Заголовок не может быть пустым",
                  onSaved: (val) => _title = val,
                ),
              ),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Описание",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: (val) =>
                    val.isNotEmpty ? null : "Описание не должно быть пустым",
                onSaved: (val) => _description = val,
              ),
              Container(
                child: new TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(labelText: "Телефон"),
                  validator: (val) => _checkCorrectNumber(val)
                      ? null
                      : "Проверьте корректность номера. Пример: 79142639094",
                  onSaved: (val) => _telephone = val,
                ),
              ),
              Container(
                child: new TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      labelText: "Стоимость"),
                  validator: (val) => val != null
                      ? null
                      : "Введите корректную стоимость",
                  initialValue: "0",
                  onSaved: (val) => _cost = val,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _choose,
                    child: Text('Choose Image'),
                  ),
                  SizedBox(width: 10.0),
                  RaisedButton(
                    onPressed: _upload,
                    child: Text('Upload Image'),
                  )
                ],
              ),
              file == null
                  ? Text('No Image Selected')
                  : Image.file(file)
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () => _submit(), child: new Icon(Icons.check)),
    );
  }

  bool _checkCorrectNumber(String val) {
    return val.length == 11;
  }
}
