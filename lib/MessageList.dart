import 'package:flutter/material.dart';
import 'Message.dart';


class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key? key, required this.title}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  late Future<List<Message>> messages;

  @override
  void initState() {
    messages = Message.browse();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                var _messages = Message.browse();

                setState(() {
                  messages = _messages;
                });
              })
        ],
      ),
      body: FutureBuilder(
        future: messages, //Data source
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
                  );
                }, separatorBuilder: (BuildContext context, int index) => Divider(),
              );
          }
        },

      )
    );
  }
}


