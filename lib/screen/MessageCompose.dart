import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/Message.dart';
import 'package:flutter_email_client_app/Provider.dart';
import 'package:flutter_email_client_app/RxTextField.dart';
import 'package:flutter_email_client_app/manager/MessageFormManager.dart';

class MessageCompose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);

    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Message'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: RxTextField(
                        // point free programming - construct functions where don't need to specify parameters
                        subscribe: manager.email$,
                        dispatch:manager.setEmail,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add),
                          labelText: 'TO',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                ),
                ListTile(
                  title: RxTextField(
                        subscribe: manager.subject$,
                        dispatch: manager.setSubject,
                        decoration: InputDecoration(
                          labelText: 'SUBJECT',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                ),
                Divider(),
                ListTile(
                  title: RxTextField(
                        subscribe: manager.body$,
                        dispatch: manager.setBody,
                        decoration: InputDecoration(
                          labelText: 'BODY',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        maxLines: 8,
                      ),
                ),
                ListTile(
                  title: StreamBuilder<Object>(
                    // A Stream of true (there is data) or error
                    stream: manager.isFormValid$,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        child: Text('SEND'),
                        onPressed: () {
                          if (snapshot.hasData) {
                            Message message = manager.submit();
                            Navigator.pop(context, message);
                          }
                        },
                      );
                    }
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}