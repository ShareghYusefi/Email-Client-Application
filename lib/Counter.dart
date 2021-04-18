import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/CounterManager.dart';
import 'package:flutter_email_client_app/Provider.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);

    return Center(
      child: StreamBuilder<int>(
        initialData: 0,
        stream: manager.counter$,
        builder: (context, snapshot) {
          return Text("Calendar: ${snapshot.data}");
        }
      ),
    );
  }
}
