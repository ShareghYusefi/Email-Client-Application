import 'package:flutter/material.dart';

class MessageCompose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Message'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Compose Message"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: ElevatedButton(
                    child: Text('Love'),
                    onPressed: (){
                      Navigator.pop(context, "love");
                    },
                  )
              ),
              Container(width: 20.0,),
              Expanded(
                  child: ElevatedButton(
                    child: Text('Hate'),
                    onPressed: (){
                      Navigator.pop(context, "hate");
                    },
                  )
              ),
              ],
          ),
        ],
        ),
      ),
    );
  }
}