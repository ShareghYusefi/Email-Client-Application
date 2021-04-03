import 'dart:convert';
import 'package:flutter/material.dart';
import 'Message.dart';
import 'package:http/http.dart' as http;



class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key? key, required this.title}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<Message> messages = const [];

  Future loadMessageList() async {
    // String content = await rootBundle.loadString('data/messages.json');
    http.Response response = await http.get(Uri.parse('https://run.mocky.io/v3/37398798-2df2-4838-9b19-d7d7d2fb0d28'));
    String content = response.body;
    List collection = json.decode(content); // Take json string data and turn into a collection of Map data set
    List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList(); // Transform from collection of Map data set to a list of Message Objects

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
            title: Text(message.subject),
            subtitle: Text(message.body, maxLines: 2, overflow: TextOverflow.ellipsis,),
            isThreeLine: true,
          );
        }, separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}


