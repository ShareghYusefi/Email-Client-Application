import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/ComposeButton.dart';
import 'package:flutter_email_client_app/MessageDetail.dart';
import 'Message.dart';


class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key? key, required this.title}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  late Future<List<Message>> future;
  late List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    future = Message.browse();
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                var _messages = await Message.browse();

                setState(() {
                  messages = _messages;
                });
              })
        ],
      ),
      body: FutureBuilder(
        future: future, //Data source
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if(snapshot.hasError){
                return Text("There was an error ${snapshot.error}");
              }
              var messages = snapshot.data;
              return ListView.separated(
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
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MessageDetail(subject: message.subject, body: message.body,)) );
                    },
                  );
                }, separatorBuilder: (BuildContext context, int index) => Divider(),
              );
          }
        },

      ),
      floatingActionButton: ComposeButton(messages)
    );
  }
}


