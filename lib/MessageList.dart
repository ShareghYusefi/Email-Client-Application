import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/ComposeButton.dart';
import 'package:flutter_email_client_app/MessageDetail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("myemail@email.com"),
                accountEmail: Text("Sultan"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1602471615287-d733c59b79c4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80"),
              ),
              otherAccountsPictures: [
                GestureDetector(
                  onTap: (){
                    showDialog(context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text("Adding new account..."),
                      );
                    });
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.inbox),
              title: Text("Inbox"),
              trailing: Chip(
                label: Text("9", style: TextStyle(fontWeight: FontWeight.bold),),
                backgroundColor: Colors.blue[100],
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),
              title: Text("Draft"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.archive),
              title: Text("Archive"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paperPlane),
              title: Text("Sent"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.trash),
              title: Text("Trash"),
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.cog),
                  title: Text("Settings"),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ComposeButton(messages)
    );
  }
}


