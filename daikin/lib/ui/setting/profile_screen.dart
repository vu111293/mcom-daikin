import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/pages/main.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ProfileScreen extends StatefulWidget {
  bool isLogin;
  ProfileScreen({Key key, this.isLogin = false}) : super(key: key);
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  final _dateController = TextEditingController();

  String date;

  @override
  void initState() {
    setState(() {
      _status = !widget.isLogin;
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   _dateController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    BaseHeaderScreen(
                      title: widget.isLogin ? "Update Profile".toUpperCase() : "Profile".toUpperCase(),
                      isBack: widget.isLogin ? false : true,
                      hideProfile: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 150,
                        child: Stack(fit: StackFit.loose, children: <Widget>[
                          Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: ExactAssetImage('assets/images/userImage.png'),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Positioned(
                            top: 90,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 23.0,
                              child: Icon(
                                Icons.mode_edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  // enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Email ID',
                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  decoration: const InputDecoration(hintText: "Enter Email ID"),
                                  // enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Mobile',
                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  decoration: const InputDecoration(hintText: "Enter Mobile Number"),
                                  // enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      // Padding(
                      //     padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: <Widget>[
                      //         Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //             Text(
                      //               'Date',
                      //               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     )),
                      // Padding(
                      //     padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: <Widget>[
                      //         Flexible(
                      //           child: TextField(
                      //             controller: _dateController,
                      //             onTap: () {
                      //               DatePicker.showDatePicker(
                      //                 context,
                      //                 showTitleActions: true,
                      //                 onChanged: (date) {
                      //                   _dateController.text = formatDate(date, [dd, '-', mm, '-', yyyy]).toString();
                      //                   print('change $date');
                      //                 },
                      //                 onConfirm: (date) {
                      //                   _dateController.text = formatDate(date, [dd, '-', mm, '-', yyyy]).toString();
                      //                   print('confirm $date');
                      //                 },
                      //                 currentTime: DateTime.now(),
                      //                 locale: LocaleType.vi,
                      //               );
                      //             },
                      //             readOnly: true,
                      //             decoration: const InputDecoration(hintText: "Enter Mobile Number"),
                      //             // enabled: !_status,
                      //           ),
                      //         ),
                      //       ],
                      //     )),
                      Align(alignment: Alignment.center, child: _getActionButtons())
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                child: RaisedButton(
              child: widget.isLogin
                  ? Text(
                      "Update".toUpperCase(),
                      style: ptButton(context).copyWith(color: Colors.white),
                    )
                  : Text(
                      "Save".toUpperCase(),
                      style: ptButton(context).copyWith(color: Colors.white),
                    ),
              textColor: Colors.white,
              color: ptPrimaryColor(context),
              onPressed: () {
                setState(() {
                  if (widget.isLogin) {
                    Routing().navigate2(context, MainScreen(), replace: true);
                  }
                  _status = true;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            )),
            flex: 2,
          ),
          // widget.isLogin
          //     ? SizedBox()
          //     : Expanded(
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 10.0),
          //           child: Container(
          //               child: RaisedButton(
          //             child: Text(
          //               "Cancel".toUpperCase(),
          //               style: ptButton(context).copyWith(color: Colors.white),
          //             ),
          //             textColor: Colors.white,
          //             color: Colors.red,
          //             onPressed: () {
          //               setState(() {
          //                 _status = true;
          //                 FocusScope.of(context).requestFocus(FocusNode());
          //               });
          //             },
          //             padding: EdgeInsets.symmetric(vertical: 16),
          //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          //           )),
          //         ),
          //         flex: 2,
          //       ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
