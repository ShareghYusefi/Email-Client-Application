import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/AppDrawer.dart';

import 'MessageList.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () async { })
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Important",
                ),
                Tab(text: "Other",)
              ],
            ),
          ),
          drawer: AppDrawer(),
          body: TabBarView(
            children: [
              MessageList(status:'important'),
              MessageList(status: 'other'),
            ],
          ),
      ),
      length: 2,
    );
  }
}
