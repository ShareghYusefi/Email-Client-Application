import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/model/Contact.dart';

import 'ContactManager.dart';
import 'Provider.dart';
import 'overseer.dart';

class ContactListBuilder extends StatelessWidget {
  final Function builder;
  final Stream stream;

  const ContactListBuilder({required this.builder, required this.stream});

  @override
  Widget build(BuildContext context) {
    // Access data available through provider class
    ContactManager manager = Provider.of(context).fetch(ContactManager);

    return StreamBuilder<dynamic>(
      stream: stream,
      // Snapshot is the data being yielded by stream
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text("There was an error ${snapshot.error}");
            }
            List<Contact> contacts = snapshot.data!;
            return builder(context, contacts);
        }
      },
    );
  }
}
