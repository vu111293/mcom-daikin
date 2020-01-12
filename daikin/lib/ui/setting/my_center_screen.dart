import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCenterScreen extends StatefulWidget {
  bool isUpdate;
  MyCenterScreen({Key key, this.isUpdate = false}) : super(key: key);
  @override
  MyCenterScreenState createState() => MyCenterScreenState();
}

class MyCenterScreenState extends State<MyCenterScreen> with SingleTickerProviderStateMixin {
  bool _status = false;
  final FocusNode myFocusNode = FocusNode();

  String date;

  @override
  void initState() {
    setState(() {
      _status = widget.isUpdate;
    });
    super.initState();
  }

  void _settingModalBottomSheet(context, bool isEdit) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: HexColor(appBorderColor))),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Thiết bị',
                            style: ptTitle(context),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.close,
                              color: HexColor(appBorderColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Image.asset(
                        "assets/devices/sun.png",
                        fit: BoxFit.contain,
                        width: 45,
                        color: HexColor(appColor),
                      ),
                    ),
                    titleField(
                      title: 'Tên thiết bị',
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                  // enabled: !_status,
                                  ),
                            ),
                          ],
                        )),
                    titleField(
                      title: 'IP',
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                  // enabled: !_status,
                                  ),
                            ),
                          ],
                        )),
                    titleField(
                      title: 'Tài khoản',
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                  // enabled: !_status,
                                  ),
                            ),
                          ],
                        )),
                    titleField(
                      title: 'Mật khẩu',
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(obscureText: true
                                  // enabled: !_status,
                                  ),
                            ),
                          ],
                        )),
                    Align(alignment: Alignment.center, child: _getActionButtons(isEdit)),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _settingModalBottomSheet(context, false);
          },
          child: new Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            BaseHeaderScreen(
              title: "Thiết Bị trung tâm".toUpperCase(),
              isBack: true,
            ),
            BaseHeaderScreen(
              hideProfile: true,
              isSubHeader: true,
              title: "Thiết bị trung tâm",
              subTitle: "Thêm hoặc chỉnh sửa thông thiết bị",
            ),
            Padding(
              padding: EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Danh sách thiết bị trung tâm",
                    style: ptBody1(context).copyWith(color: ptPrimaryColor(context)),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: ptPrimaryColor(context),
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    child: Center(
                      child: Text(
                        "10",
                        style:
                            ptCaption(context).copyWith(color: Colors.white, fontSize: ptCaption(context).fontSize - 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                // padding: EdgeInsets.only(top: 58, left: 16, right: 16, bottom: 4),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 40, // can be whatever value you want
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/devices/sun.png",
                        width: 20,
                        height: 20,
                        color: HexColor(appColor),
                      ),
                    ),
                    title: Text(
                      'Thiết bị $index',
                      style: ptSubtitle(context),
                    ),
                    subtitle: Text(
                      'IP: 5s638snsjd88v33asd1as5d1a2sd1',
                      style: ptCaption(context),
                    ),
                    trailing: GestureDetector(
                        onTap: () {
                          _settingModalBottomSheet(context, true);
                        },
                        child: Icon(Icons.edit)),
                  );
                },
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons(isEdit) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                child: RaisedButton(
              child: Text(
                isEdit ? "xóa thiết bị".toUpperCase() : "xác nhận".toUpperCase(),
                style: ptButton(context).copyWith(color: Colors.white),
              ),
              textColor: Colors.white,
              color: isEdit ? Colors.redAccent : ptPrimaryColor(context),
              onPressed: () {
                setState(() {
                  _status = true;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            )),
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class titleField extends StatelessWidget {
  String title;
  titleField({
    Key key,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}
