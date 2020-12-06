import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  static const routeName = '/feed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text('feed screen'),
          ),
          RaisedButton(
              child: Text('do'),
              onPressed: () async {
                final test = await FirebaseFirestore.instance
                    .collection('messageRooms/8N3IpKkfU2IxSepccF7f/messages').get();
                    print(test.docs[0]['text']);
              })
        ],
      )),
    );
  }
}
