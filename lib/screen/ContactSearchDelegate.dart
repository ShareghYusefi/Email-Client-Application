import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/ContactListBuilder.dart';
import 'package:flutter_email_client_app/Provider.dart';
import 'package:flutter_email_client_app/manager/ContactManager.dart';
import 'package:flutter_email_client_app/model/Contact.dart';

class ContactSearchDelegate extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query = '';
      },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
          onPressed: (){
          close(context, null);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);

    // if (query.length < 3) {
    //   return Center(
    //     child: Text("Type at least 3 letters to search"),
    //   );
    // }

    // Use Delegate class query getter to add data to inFilter stream sink
    manager.inFilter.add(query);

    return ContactListBuilder(
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
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
  
  
  
}