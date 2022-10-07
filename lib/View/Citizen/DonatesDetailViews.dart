import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';

class DonatesDetailViews extends StatelessWidget {
  String title;
  DonatesDetailViews(String title){
    this.title = title;
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(

      appBar: primaryAppBar(title),
      body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  height: screenSize.height /11,
                  child: Text("TR 424242 242 42 424 24",style: kTextStyle,),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  height: screenSize.height /5.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Yukarıdaki ibana bağış yapabilirsiniz.",textAlign: TextAlign.center,style: kTextStyle,),
                  ),
                ),

              ],
            ),
          ),


    );
  }
}
