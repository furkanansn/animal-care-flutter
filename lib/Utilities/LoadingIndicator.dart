import 'package:flutter/material.dart';

loading(context){
  return showDialog(barrierColor: Colors.transparent,barrierDismissible: false,context: context, builder: (context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator(strokeWidth: 20,color: Colors.orange,))
        ],
      ),
    );
  },);
}