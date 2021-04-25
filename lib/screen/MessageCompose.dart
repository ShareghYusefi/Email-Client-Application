import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/Message.dart';
import 'package:flutter_email_client_app/Provider.dart';
import 'package:flutter_email_client_app/manager/MessageFormManager.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {

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
                  // Observer observes the value of the stream connected and renders code as a response to data
                  title: StreamBuilder(
                    stream: manager.email$,
                    builder: (context, snapshot) {
                      return TextField(
                        // point free programming - construct functions where don't need to specify parameters
                        onChanged: manager.inEmail.add,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add),
                          labelText: 'TO',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          errorText: snapshot.error == null ? null : snapshot.error.toString(),
                      ),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: StreamBuilder<Object>(
                    stream: manager.subject$,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: manager.inSubject.add,
                        decoration: InputDecoration(
                          labelText: 'SUBJECT',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          errorText: snapshot.error == null ? null : snapshot.error.toString(),
                        ),
                      );
                    }
                  ),
                ),
                Divider(),
                ListTile(
                  title: StreamBuilder<Object>(
                    stream: manager.body$,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: manager.inBody.add,
                        decoration: InputDecoration(
                          labelText: 'BODY',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          errorText: snapshot.error == null ? null : snapshot.error.toString(),
                        ),
                        maxLines: 8,
                      );
                    }
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