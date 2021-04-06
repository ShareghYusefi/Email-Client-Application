import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/MessageDetail.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Message.dart';


class MessageList extends StatefulWidget {
  final String status;

  const MessageList({Key? key, this.status = 'important'}) : super(key: key);

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
    future = Message.browse(status: widget.status);
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Archive',
                        color: Colors.blue,
                        icon: Icons.archive,
                        onTap: () => {},
                      ),
                      IconSlideAction(
                        caption: 'Share',
                        color: Colors.indigo,
                        icon: Icons.share,
                        onTap: () => {},
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () => {},
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => {
                          setState(() {
                            messages.removeAt(index);
                          })
                        },
                      ),
                    ],
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('PJ'),
                      ),
                      title: Text(message.subject),
                      subtitle: Text(message.body, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MessageDetail(subject: message.subject, body: message.body,)
                            )
                        );
                      },
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) => Divider(),
              );
          }
        },
      );
  }
}


