import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Notifications extends StatefulWidget {
  String data;
  Notifications(String data) {
    this.data = data;
  }

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(widget.data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
