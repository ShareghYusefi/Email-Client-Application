import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/Message.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to = "";
  String subject = "";
  String body = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Message'),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: TextField(
                  onChanged: (value){
                    to = value;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.add),
                      labelText: 'TO',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              ListTile(
                title: TextField(
                  onChanged: (value){
                    subject = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'SUBJECT',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: TextField(
                  onChanged: (value){
                    body = value;
                  },
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
                    Message message = Message(subject, body);
                    Navigator.pop(context, message);
                  },
                ),
              )
            ],
          ),
      ),
    );
  }
}