import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/material.dart';

class InformationBankDetailView extends StatelessWidget {
  String title;
  String content;

  InformationBankDetailView(String title, String content) {
    this.content = content;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar(title),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content,
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
