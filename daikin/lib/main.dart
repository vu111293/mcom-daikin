import 'package:daikin/apis/graphql/graphql.dart';
import 'package:daikin/apis/graphql/graphql_config.dart';
import 'package:daikin/apis/net/user_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:graphql/client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                "Click",
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),
              onTap: () async {
                var result = await UserService().login("FB|Zwb4rBlGW2O8tiJnU4vsVSwoJaz2|eyJhbGciOiJSUzI1NiIsImtpZCI6IjUxMjRjY2JhZDVkNWZiZjNiYTJhOGI1ZWE3MTE4NDVmOGNiMjZhMzYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGFpa2luLWNmMDg1IiwiYXVkIjoiZGFpa2luLWNmMDg1IiwiYXV0aF90aW1lIjoxNTc4NDc0NjQzLCJ1c2VyX2lkIjoiWndiNHJCbEdXMk84dGlKblU0dnNWU3dvSmF6MiIsInN1YiI6Ilp3YjRyQmxHVzJPOHRpSm5VNHZzVlN3b0phejIiLCJpYXQiOjE1Nzg0NzQ2NDQsImV4cCI6MTU3ODQ3ODI0NCwicGhvbmVfbnVtYmVyIjoiKzg0MTIzNDU2Nzg5IiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrODQxMjM0NTY3ODkiXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwaG9uZSJ9fQ.Ga25kPMsnjL7OeSAxIfLVduGMg8ZwPWMbMejvPjhOTi--yVD562_EMlLfNdyJbAMA5uj6vNxaD7uIVuCon2aIUy3tzQot8cLhwMZvoVs9UVeeVGFG29MQLHSC67VRrfReqUfoEqCaJPEdklo0vrOaQwOHBr3O5LCAeY9h4hwusmcLsh3UHeDdB-4BWV2oXdpAYR1WLmSs5Y-tZeU4xSEwPUG4LbpTXfnsqsPczUMYDeoM-5KGNYQpXnaUSdOVcYsbVABQReb7jScx2-qII5ayumiAh6tWx_YDySaNzgu086qA3s5qQuOop6NAnwF82X-8Du1Rsj_2QQO6iKrcfJdEw");

                print(result.toJson());
              },
            )
          ],
        )),
      ),
    );
  }
}
