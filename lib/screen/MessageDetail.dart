import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageDetail extends StatelessWidget {
  final subject;
  final body;

  MessageDetail({this.subject, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(subject),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Html(
            data: body,
            onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, element) async {
              await launch(url!);
              // if(await canLaunch(url!)) {
              //   await launch(url);
              // } else {
              //   throw "Link cannot be handled";
              // }
            }
          ),
      ),
    );
  }
}