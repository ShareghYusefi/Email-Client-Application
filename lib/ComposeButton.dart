import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/Message.dart';
import 'package:flutter_email_client_app/screen/MessageCompose.dart';

class ComposeButton extends StatelessWidget {
  final List<Message> messages;
  ComposeButton(this.messages);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        // Navigator returns a future
        Message? message = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MessageCompose())
        );
        // Show message when future string data is completed and returned
        if (message != null) {
          messages.add(message);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Your Message has been sent"),
                backgroundColor: Colors.green,)
          );
        }
      },
    );
  }
}
