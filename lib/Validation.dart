// Module meant to add feature and functionality to other classes - Mixins

// mixin key work ensures we wont be able to create an instance of this entity
import 'dart:async';

mixin Validation {
  // Simple validation for email field, will replace with an elaborate library in future
  static bool isEmail(String email) => email.contains('@');

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    // handle data receive a value and pass to the provided sink
      handleData: (value, sink){
        if( isEmail(value)){
          sink.add(value);
        } else {
          sink.addError("Our message error");
        }
      });

  final validateSubject = StreamTransformer<String, String>.fromHandlers(
    // handle data receive a value and pass to the provided sink
      handleData: (value, sink){
       value.length == 0
           ? sink.addError("'Subject' Field is required")
           : sink.add(value);
      });

}