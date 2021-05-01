import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/overseer.dart';

class Provider extends InheritedWidget {

  // Data we will provide to other widgets
  final Overseer data;

  // child Widget is where we want to attach the data
  Provider({Key? key, Widget? child, required this.data}) : super(key: key, child: child!);

  // of method for convenience to return ContactManager class directly
  static Overseer of(BuildContext context){
    // Get the closest instance of provider and cast as provider and return its data
    return  (context.dependOnInheritedWidgetOfExactType<Provider>())!.data;
  }

  // We will be using InheritedWidget in a immutable sense where it will not change
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}