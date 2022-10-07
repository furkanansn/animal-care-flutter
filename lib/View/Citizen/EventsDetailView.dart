import 'package:bi_pati/Models/EventModel.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/material.dart';

class EventsDetailView extends StatelessWidget {
  String title;
  Event event;

  EventsDetailView(String title, Event event) {
    this.title = title;
    this.event = event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar(event.title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Etkinlik Adı: " + event.title,
                      style: kLabelBlackStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Etkinlik Tarihi: " + event.eventDate.toString(),
                      style: kLabelBlackStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Etkinlik Yeri: " + event.location,
                      style: kLabelBlackStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Etkinlik Açıklaması: " + event.content,
                      style: kLabelBlackStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Text(
                    "GALERİ",
                    style: kLabelBlackStyle,
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  GridView.count(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(event.galleries.length, (index) {
                      return Container(
                        child: Card(
                          child: Image.network(
                            getImagePath(event.galleries[index].photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
