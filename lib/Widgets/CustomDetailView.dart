import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class CustomDetailView extends StatefulWidget {
  final ValueChanged<DetailObject> onChanged;
  final DetailObject detailObject;

  const CustomDetailView({Key key, this.onChanged, this.detailObject})
      : super(key: key);
  @override
  _CustomDetailViewState createState() => _CustomDetailViewState();
}

class _CustomDetailViewState extends State<CustomDetailView> {
  DetailObject detailObject = new DetailObject();

  @override
  void initState() {
    if (widget.detailObject != null) {
      detailObject = widget.detailObject;
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 300,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: InkWell(
                    onTap: () async {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1930, 01, 01),
                          maxTime: DateTime(2021, 12, 31), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          detailObject.beginDate = formattedDate;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.tr);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        detailObject.beginDate == null ||
                                detailObject.beginDate.isEmpty
                            ? "Başlangıç Tarihi"
                            : detailObject.beginDate,

                        style: TextStyle(color: Colors.white),
                        //set it true, so that user will not able to edit text
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: InkWell(
                    onTap: () async {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1930, 01, 01),
                          maxTime: DateTime(2021, 12, 31), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          detailObject.endDate = formattedDate;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.tr);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        detailObject.endDate == null ||
                                detailObject.endDate.isEmpty
                            ? "Bitiş Tarihi"
                            : detailObject.endDate,

                        style: TextStyle(color: Colors.white),
                        //set it true, so that user will not able to edit text
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text("Devam ediyor mu?"),
                    Checkbox(
                      value: detailObject.isContinue == null
                          ? false
                          : detailObject.isContinue,
                      onChanged: (value) {
                        detailObject.isContinue = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        elevation: 5.0,
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.white,
                        onPressed: () {
                          widget.onChanged(detailObject);
                        },
                        child: Text(
                          "Kaydet",
                          style: TextStyle(
                            color: primaryColor,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailObject {
  String beginDate;
  String endDate;
  bool isContinue;
}
