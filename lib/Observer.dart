// This is a utility class to wrap streams for simplicity in code
import 'package:flutter/material.dart';

class Observer<T> extends StatelessWidget {

  final Stream<T> stream;
  // ? operator indicates onError function can be nullable
  final Function? onError;
  final Function onSuccess;
  final Function? onWaiting;

  Function get _defaultOnWaiting => (context) => Center(child: CircularProgressIndicator());

  Function get _defaultOnError => (context, error) => Center(child: Text(error));

  const Observer({required this.onSuccess, required this.stream, this.onError, this.onWaiting});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return (onError != null) ? onError!(context, snapshot.error) : _defaultOnError(context, snapshot.error);
        }

        if (snapshot.hasData) {
          // Builds the UI here using onSuccess callback function
          T data = snapshot.data!;
          return onSuccess(context, data);
        } else {
          return (onWaiting != null)
              ? onWaiting!(context)
              : _defaultOnWaiting(context);
        }
      },
    );
  }
}
