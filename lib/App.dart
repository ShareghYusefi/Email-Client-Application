import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/AppDrawer.dart';
import 'package:flutter_email_client_app/CalendarScreen.dart';
import 'package:flutter_email_client_app/ContactsScreen.dart';
import 'package:flutter_email_client_app/InboxScreen.dart';

import 'MessageList.dart';


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        InboxScreen(),
        ContactsScreen(),
        CalendarScreen()
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Inbox'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Contacts'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar'
          ),
        ],
        onTap: (value) => _onBarItemTap(value),
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onBarItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}

