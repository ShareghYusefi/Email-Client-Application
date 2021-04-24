// A class that manages managers like a dispatcher
import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/manager/MessageFormManager.dart';
import 'package:flutter_email_client_app/manager/MessageFormManager.dart';

import 'manager/ContactManager.dart';
import 'manager/CounterManager.dart';

class Overseer {
  // A list of manager that can be accessed by overseer
  Map<dynamic, dynamic> repository = {};

  Overseer() {
    register(ContactManager, ContactManager());
    register(CounterManager, CounterManager());
    register(MessageFormManager, MessageFormManager());
  }

  // A way to hire managers for the garden
  register(name, object) {
    repository[name] = object;
  }
  // Fetch a manager for some work
  fetch(name) => repository[name];
}