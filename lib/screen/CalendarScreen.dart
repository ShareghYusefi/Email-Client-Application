import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/AppDrawer.dart';
import 'package:flutter_email_client_app/FabButton.dart';
import '../Counter.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      drawer: AppDrawer(),
      body: Counter(),
      floatingActionButton: FabButton(),
    );
  }
}