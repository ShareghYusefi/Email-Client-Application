import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/MessageCompose.dart';

class ComposeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        // Navigator returns a future
        String intention = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MessageCompose()));
        // Show message when future string data is completed and returned
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Message has been sent with $intention"), backgroundColor: Colors.green,));
      },
    );
  }
}
