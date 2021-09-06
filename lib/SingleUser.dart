import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Map mapResponse = {};
Map dataResponse = {};

class SingleUser extends StatefulWidget {
  @override
  _SingleUserState createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        dataResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API INTEGRATION'),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          color: Colors.blue,
          child: dataResponse == null
              ? Container()
              : Center(child: Text(dataResponse['first_name'].toString())),
        ),
      ),
    );
  }
}
