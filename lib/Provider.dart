import 'package:flutter/material.dart';
import 'ContactManager.dart';

class Provider<T> extends InheritedWidget {

  // Data we will provide to other widgets
  final T data;

  // child Widget is where we want to attach the data
  Provider({Key? key, Widget? child, required this.data}) : super(key: key, child: child!);

  // of method for convenience to return ContactManager class directly
  static ContactManager of<T>(BuildContext context){
    // final type = _typeOf<Provider<T>>();
    // Get the closest instance of provider and cast as provider and return its data
    return  (context.dependOnInheritedWidgetOfExactType<Provider<T>>() as Provider).data;
  }

  // helper method
  // static Type _typeOf<T>() => T;

  // We will be using InheritedWidget in a immutable sense where it will not change
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}