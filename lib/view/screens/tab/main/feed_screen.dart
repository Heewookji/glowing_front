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
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(''),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
