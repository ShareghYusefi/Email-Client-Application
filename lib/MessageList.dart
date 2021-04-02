import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Message.dart';


class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  var messages = const [];

  Future loadMessageList() async {
    String content = await rootBundle.loadString('data/messages.json');
    List collection = json.decode(content);
    print(collection);
    List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList();

    setState(() {
      messages = _messages;
    });
  }

  @override
  void initState() {
    loadMessageList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          Message message = messages[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text('PJ'),
            ),
            title: Text(message.subject ?? ''),
            subtitle: Text(message.body ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,),
            isThreeLine: true,
          );
        }, separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}


