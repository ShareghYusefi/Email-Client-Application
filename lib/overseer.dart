// A class that manages managers like a dispatcher
import 'package:flutter_email_client_app/manager/MessageFormManager.dart';
import 'Manager.dart';
import 'manager/ContactManager.dart';
import 'manager/CounterManager.dart';

class Overseer {
  // A list of manager that can be accessed by overseer
  Map<dynamic, Manager> repository = {};
  // Once a manager key is called, an instance is created and returned using a function (differing instantiation)
  Map<dynamic, Function> _factories = {
      ContactManager: () => ContactManager(),
      CounterManager: () => CounterManager(),
      MessageFormManager: () => MessageFormManager()
  };

  // factory constructor returns the internal instance instead of a new instance of the class
  factory Overseer() => _singleton;

  static final Overseer _singleton = Overseer._internal();
  Overseer._internal();

  _summon(name){
    // search through factories and return association
    Function managerFactory = _factories[name]!;
    // store the instance in repository until next time it is called
    repository[name] = managerFactory();

    return repository[name];
  }

  // return instance in repository or create new
  fetch(name) => repository.containsKey(name) ? repository[name] : _summon(name);

  // allow overseer to release all manager that need to be replaced
  release(name) {
    Manager manager = repository[name]!;

    manager.dispose();

    repository.remove(name);
  }
}