import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/AppDrawer.dart';
import 'package:flutter_email_client_app/manager/ContactManager.dart';
import 'package:flutter_email_client_app/model/Contact.dart';
import '../ContactCounter.dart';
import '../ContactListBuilder.dart';
import '../Provider.dart';
import 'ContactSearchDelegate.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access data available through provider class
    ContactManager manager = Provider.of(context).fetch(ContactManager);

    // Passing an empty query so that the filter stream executes for the first time
    manager.inFilter.add('');

    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          ContactCounter(),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: ContactSearchDelegate()
                );
              },
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ContactListBuilder(
          stream: manager.browse$,
          builder: (context, contacts) {
            return ListView.separated(
              itemCount: contacts.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                Contact _contact = contacts[index];
                return ListTile(
                  title: Text(_contact.name),
                  subtitle: Text(_contact.email),
                  leading: CircleAvatar(),
                );
              },
            );
          }
      )
      );
  }
}
