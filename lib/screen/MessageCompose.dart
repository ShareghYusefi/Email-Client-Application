import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/Message.dart';
import 'package:flutter_email_client_app/Observer.dart';
import 'package:flutter_email_client_app/Provider.dart';
import 'package:flutter_email_client_app/manager/MessageFormManager.dart';
import 'package:flutter_email_client_app/manager/MessageFormManager.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to = "";
  String subject = "";
  String body = "";

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);

    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Message'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  // Observer observes the value of the stream connected and renders code as a response to data
                  title: Observer(
                    stream: manager.email$,
                    onSuccess: (context, data) {
                      return TextField(
                          // onChanged: (value){
                          //   manager.inEmail.add(value);
                          // },
                        // point free programming - construct functions where don't need to specify parameters
                        onChanged: manager.inEmail.add,
                          decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add),
                          labelText: 'TO',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)
                          ),
                        );
                    },
                    onError: (context, error) {
                      return TextField(
                        onChanged: manager.inEmail.add,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.add),
                            labelText: 'TO',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            errorText: error,
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    validator: (value) => value!.length == 0 ? "'Subject' Field is required" : null,
                    onSaved: (value) => subject = value!,
                    decoration: InputDecoration(
                        labelText: 'SUBJECT',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: TextFormField(
                    onSaved: (value) => body = value!,
                    decoration: InputDecoration(
                      labelText: 'BODY',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    maxLines: 8,
                  ),
                ),
                ListTile(
                  title: ElevatedButton(
                    child: Text('SEND'),
                    onPressed: () {
                      if (this.key.currentState!.validate()) {
                        // Use the key reference to save/assign the state
                        this.key.currentState!.save();
                        Message message = Message(subject, body);
                        Navigator.pop(context, message);
                      }
                    },
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}