import 'package:flutter/material.dart';

import 'manager/CounterManager.dart';
import 'Provider.dart';

class FabButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterManager manager = Provider.of(context).fetch(CounterManager);


    return FloatingActionButton(onPressed: manager.increment );
  }
}
