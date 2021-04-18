import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/model/Contact.dart';
import 'Observer.dart';

class ContactListBuilder extends StatelessWidget {
  final Function builder;
  final Stream stream;

  const ContactListBuilder({required this.builder, required this.stream});

  @override
  Widget build(BuildContext context) {
    return Observer<dynamic>(
      stream: stream,
      onSuccess: (BuildContext context, List<Contact> data) => builder(context, data),
      onWaiting: (context) => LinearProgressIndicator(),
    );
  }
}
