import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/Observer.dart';
import 'package:flutter_email_client_app/Provider.dart';
import 'package:flutter_email_client_app/manager/CounterManager.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);

    return Center(
      child: Observer<int>(
        stream: manager.counter$,
        onSuccess: (context, data) {
          return Text("Calendar: $data");
        }
      ),
    );
  }
}
