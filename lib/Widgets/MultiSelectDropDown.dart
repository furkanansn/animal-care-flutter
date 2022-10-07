import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/Widgets/CustomDetailView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class MultiselectDropDown extends StatefulWidget {
  final Function(List<Disease>) selectedList;
  final List<dynamic> listOFStrings;
  final List<dynamic> listOfBeginDates;
  final List<dynamic> listOfFinishDates;
  final List<dynamic> listOfIsContinue;
  final List<dynamic> listOfSelectedItem;
  final String name;
  final ValueChanged<List<Disease>> onChanged;
  final context;

  MultiselectDropDown(
      {Key key,
      this.selectedList,
      this.listOFStrings,
      this.listOfSelectedItem,
      this.listOfBeginDates,
      this.listOfFinishDates,
      this.listOfIsContinue,
      this.name,
      this.onChanged,
      this.context})
      : super(key: key);

  @override
  createState() {
    return new _MultiselectDropDownState();
  }
}

class _MultiselectDropDownState extends State<MultiselectDropDown> {
  ProfileController profileController = Get.find();
  List<String> listOFSelectedItem = [];
  String selectedText = "";
  List<dynamic> listOfBeginDates = [];
  List<dynamic> listOfFinishDates = [];
  List<dynamic> listOfIsContinue = [];
  List<Disease> generalList = [];
  @override
  void initState() {
    listOfBeginDates = widget.listOfBeginDates;
    listOfFinishDates = widget.listOfFinishDates;
    listOfIsContinue = widget.listOfIsContinue;
    listOFSelectedItem = widget.listOfSelectedItem;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      return Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
          Container(
            decoration: kBoxDecorationStyle,
            child: ExpansionTile(
              tilePadding: EdgeInsets.only(left: 20, right: 11),
              trailing: Icon(
                Icons.arrow_drop_down,
              ),
              iconColor: Colors.grey,
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  listOFSelectedItem.isEmpty
                      ? widget.name
                      : listOFSelectedItem.join(", "),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              children: <Widget>[
                (getRxValueOfItems(widget.name) == null)
                    ? Container()
                    : new ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getRxValueOfItems(widget.name).length,
                        itemBuilder: (BuildContext context, int index) {
                          print(index.toString());
                          DetailObject detailObject = new DetailObject();
                          try {
                            detailObject.beginDate = listOfBeginDates[index];
                            detailObject.endDate = listOfFinishDates[index];
                            detailObject.isContinue = listOfIsContinue[index];
                          } catch (e) {}

                          return Container(
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: _ViewItem(
                                item: getRxValueOfItems(widget.name)[index],
                                tappedText: (p0) {
                                  if (p0 == true) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          content: Container(
                                            height: 300,
                                            child: CustomDetailView(
                                              detailObject: detailObject,
                                              onChanged: (value) {
                                                print("sa");
                                                listOfBeginDates[index] =
                                                    value.beginDate;
                                                listOfFinishDates[index] =
                                                    value.endDate;
                                                listOfIsContinue[index] =
                                                    value.isContinue;
                                                Navigator.of(context).pop();
                                                for (int i = 0;
                                                    i <
                                                        listOFSelectedItem
                                                            .length;
                                                    i++) {
                                                  generalList.add(Disease(
                                                      name: listOFSelectedItem[
                                                          index],
                                                      beginDate:
                                                          listOfBeginDates[
                                                              index],
                                                      endDate:
                                                          listOfFinishDates[
                                                              index],
                                                      isContinue:
                                                          listOfIsContinue[
                                                              index]));
                                                }
                                                generalList.forEach((element) {
                                                  print(element.name);
                                                });
                                                widget
                                                    .selectedList(generalList);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                selected: (val) {
                                  selectedText = val;

                                  if (listOFSelectedItem.contains(val)) {
                                    int index = listOFSelectedItem.indexOf(val);
                                    listOfBeginDates.removeAt(index);
                                    listOfFinishDates.removeAt(index);
                                    listOfIsContinue.removeAt(index);
                                    listOFSelectedItem.remove(val);
                                    widget
                                                    .selectedList(generalList);
                                    setState(() {});
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          content: Container(
                                            height: 300,
                                            child: CustomDetailView(
                                              detailObject: detailObject,
                                              onChanged: (value) {
                                                try {
                                                  print("sa");
                                                listOfBeginDates[index] =
                                                    value.beginDate;
                                                listOfFinishDates[index] =
                                                    value.endDate;
                                                listOfIsContinue[index] =
                                                    value.isContinue;
                                                Navigator.of(context).pop();
                                                listOFSelectedItem.add(val);
                                                for (int i = 0;
                                                    i <
                                                        listOFSelectedItem
                                                            .length;
                                                    i++) {
                                                  generalList.add(Disease(
                                                      name: listOFSelectedItem[
                                                          index],
                                                      beginDate:
                                                          listOfBeginDates[
                                                              index],
                                                      endDate:
                                                          listOfFinishDates[
                                                              index],
                                                      isContinue:
                                                          listOfIsContinue[
                                                              index]));
                                                }
                                                generalList.forEach((element) {
                                                  print(element.name);
                                                });
                                                widget
                                                    .selectedList(generalList);
                                                } catch (e) {
                                                  setState(() {});
                                                }
                                                
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                itemSelected: listOFSelectedItem.contains(
                                    getRxValueOfItems(widget.name)[index])),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      );
    });
  }

  getRxValueOfItems(String name) {
    if (name == "Hastalıklar") {
      return profileController.diseasesList.value;
    } else if (name == "Ameliyatlar") {
      return profileController.surgeryList.value;
    } else {
      return profileController.medicinesList.value;
    }
  }
}

getListSafety(List list, index, String s) {
  print(list.length.toString() + " " + index.toString());
  try {
    if (list.length <= index && list.length.toString() != "0") {
      return list[index];
    } else {
      return "";
    }
  } catch (e) {
    return "";
  }
}

getListSafetyBool(List list, index, String s) {
  print(list.length.toString() + " " + index.toString());
  try {
    if (list.length <= index && list.length.toString() != "0") {
      return list[index];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

class _ViewItem extends StatelessWidget {
  String item;
  bool itemSelected;
  final Function(String) selected;
  final Function(bool) tappedText;

  _ViewItem({this.item, this.itemSelected, this.selected, this.tappedText});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * .032, right: size.width * .098),
      child: Row(
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: itemSelected,
              onChanged: (val) {
                selected(item);
              },
              activeColor: Colors.blue,
            ),
          ),
          SizedBox(
            width: size.width * .025,
          ),
          InkWell(
            onTap: () {
              tappedText(true);
            },
            child: Text(
              item,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
