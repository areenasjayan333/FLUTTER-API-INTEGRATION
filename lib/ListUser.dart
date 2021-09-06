import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Map mapResponse = {};
List listResponse = [];

class ListUser extends StatefulWidget {
  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(listResponse[index]['avatar']),
                ),
                Text(listResponse[index]['id'].toString()),
                Text(listResponse[index]['email'].toString()),
                Text(listResponse[index]['first_name'].toString()),
                Text(listResponse[index]['last_name'].toString()),
              ],
            ),
          );
        },
        itemCount: listResponse == null ? 0 : listResponse.length,
      ),
    );
  }
}
