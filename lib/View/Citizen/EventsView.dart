import 'package:bi_pati/Models/EventModel.dart';
import 'package:bi_pati/ViewModel/DataContoller.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/material.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:get/get.dart';

import 'EventsDetailView.dart';

class EventsView extends StatefulWidget {
  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  DataController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: primaryAppBar("Etkinlikler"),
      body: ListView.builder(
        itemCount: controller.events.value.length,
        itemBuilder: (context, index) {
          Event event = controller.events.value[index];
          return ListTile(
              title: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EventsDetailView("Etkinlikler", event),
                  ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.network(getImagePath(event.galleries[0].photo)),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            "Etkinlik Adı: " + event.title,
                            style: kLabelBlackStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            "Etkinlik Tarihi: " + event.eventDate.toString(),
                            style: kLabelBlackStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                Image.asset("assets/8.jpg"),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("Etkinlik Adı",style: kLabelBlackStyle, ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("Etkinlik Tarihi",style: kLabelBlackStyle, ),
                ),
                 */
              ],
            ),
          ));
        },
      ),
    );
  }
}
