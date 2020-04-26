import 'package:daikin/apis/local/room_local_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/image_picker.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

enum DialogAction {
  cancel,
  discard,
  disagree,
  agree,
}

typedef TapButtonListener(DialogAction action);
typedef TapConfirm();

void showWaitingDialog(BuildContext context, {String message}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
//          width: 300.0,
//          height: 300.0,
            backgroundColor: Colors.white,
            content: Container(
              width: double.infinity,
              height: 100.0,
              alignment: Alignment.center,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                  Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        message ?? 'Đang xử lí ...',
                        style: TextStyle(fontSize: 18.0),
                      ))
                ],
              )),
            ));
      });
}

Future<bool> showAlertDialog(BuildContext context, String errorMessage,
    {TapConfirm confirmTap, String confirmLabel}) async {
  Color primaryColor = Theme.of(context).primaryColor;
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text(errorMessage, style: TextStyle(fontSize: 18.0)),
          actions: <Widget>[
            FlatButton(
                child: Text(confirmLabel != null ? confirmLabel : 'Ok', style: TextStyle(color: primaryColor)),
                onPressed: confirmTap != null ? confirmTap : () => Navigator.pop(ctx, true)),
          ],
        );
      });
}

void showConfirmDialog(BuildContext context, String errorMessage, {TapConfirm confirmTap, Function callback}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(errorMessage, style: TextStyle(fontSize: 18.0)),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('Ok', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: confirmTap != null ? confirmTap : () => Navigator.pop(context),
            ),
          ],
        );
      });
}

Future showAlertWithTitleDialog(BuildContext context, String title, String content,
    {String firstAction,
    TapConfirm firstTap,
    String secondAction,
    TapConfirm secondTap,
    String thirdAction,
    TapConfirm thirdTap}) {
  List<Widget> actions = new List<Widget>();
  Color primaryColor = Theme.of(context).primaryColor;

  if (thirdAction != null && thirdAction.isNotEmpty) {
    actions.add(new FlatButton(
      child: Text(thirdAction, style: TextStyle(color: primaryColor)),
      onPressed: thirdTap != null ? thirdTap : () => Navigator.pop(context),
    ));
  }

  if (secondAction != null && secondAction.isNotEmpty) {
    actions.add(new FlatButton(
      child: Text(secondAction, style: TextStyle(color: primaryColor)),
      onPressed: secondTap != null ? secondTap : () => Navigator.pop(context),
    ));
  }

  actions.add(new FlatButton(
    child: Text(firstAction ?? 'Ok', style: TextStyle(color: primaryColor)),
    onPressed: firstTap != null ? firstTap : () => Navigator.pop(context),
  ));

  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content, style: TextStyle(fontSize: 18.0)),
          actions: actions,
        );
      });
}

class ChangeRoomNameDialog extends StatelessWidget {

  final TextEditingController _textFieldController = TextEditingController();
  final String initText;
  final Function(String) onSave;
  final Function onCancel;

  ChangeRoomNameDialog({this.initText, this.onSave, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Đổi tên'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: TextField(
              controller: _textFieldController..text = initText ?? '',
              decoration: InputDecoration(hintText: "Tên cho phòng"),
            )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(child: Text('Lưu'), onPressed: () {
                String r = _textFieldController.text.trim();
                onSave(r);
                Navigator.pop(context);
              })
            ])
        ],
      ),
    ));
  }
}

Future showChangeRoomNameDialog(BuildContext context, String v, {Function onCancel, Function(String) onSave}) {
  return showDialog(
      context: context,
      builder: (context) => ChangeRoomNameDialog(initText: v, onSave: onSave, onCancel: onCancel));
}



class ChangeImageAssetsDialog extends StatefulWidget {

  final List<ImageAsset> list;
  final String selectedId;
  final Function(ImageAsset) onSave;
  final Function onCancel;

  ChangeImageAssetsDialog({this.list, this.selectedId, this.onSave, this.onCancel});

  @override
  State<StatefulWidget> createState() {
    return _ChangeImageAssetsDialogState();
  }

}

class _ChangeImageAssetsDialogState extends State<ChangeImageAssetsDialog> {

//  ChangeImageAssetsDialog({this.list, this.selectedId, this.onSave, this.onCancel});
  List<ImageAsset> images;
  ImageAsset _selected;

  @override
  void initState() {
    images = List.from(widget.list);
    images.insert(0, ImageAsset(id: 'ext-add-action'));
    _selected = images.firstWhere((item) => item.id == widget.selectedId, orElse: ()=> null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Chọn hình ảnh'),
          Expanded(child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: GridView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: images.map((item) {
                  if (item.id == 'ext-add-action') {
                    return Container(
                        height: double.infinity,
                        width: double.infinity,
//                        child: Icon(Icons.camera_enhance, size: 35.0)

                        child: ImagePickerWidget(
                          context: context,
                          isEdit: true,
                          circle: true,
                          size: 100.0,
                          overrideBkg: false,
//                      resourceUrl: _appBloc.authBloc.currentUser.avatar,
                          onFileChanged: (fileUri, fileType) async {
                            final newImage =  ImageAsset(id: 'network-${DateTime.now().millisecondsSinceEpoch}', assetPath: fileUri);
                            RoomLocalService.instance.addCoverAsset(newImage);
                            images.add(newImage);
                            _selected = newImage;
                            setState(() {});
                          },
                        )
                    );
                  }

                  return InkWell(child: Stack(
                    children: <Widget>[
                      Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: item.assetPath.startsWith('http')
                              ? Image.network(item.assetPath, fit: BoxFit.cover)
                              : Image.asset(item.assetPath, fit: BoxFit.cover)),
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: item.id == _selected?.id ? Icon(Icons.check_circle, color: Colors.green) : Container())
                    ],
                  ), onTap: () {
                   setState(() {
                     _selected = item;
                   });
                  });
                }).toList(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  // childAspectRatio: MediaQuery.of(context).size.height / 600,
                ),
              )),),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(child: Text('HỦY BỎ'), onPressed: () {
                  Navigator.pop(context);
                }),
                SizedBox(width: 12.0),
                FlatButton(child: Text('LƯU'), onPressed: () {
//                  String r = _textFieldController.text.trim();
                  widget.onSave(_selected);
                  Navigator.pop(context);
                })
              ])
        ],
      ),
    ));
  }
}

Future showChangeCoverDialog(BuildContext context, String selectedId, {Function onCancel, Function(ImageAsset) onSave}) {
  List<ImageAsset> images = List.from(assetCoverList);
  images.addAll(RoomLocalService.instance.coverAssets);
  return showDialog(
      context: context,
      builder: (context) => ChangeImageAssetsDialog(list: images, selectedId: selectedId, onSave: onSave, onCancel: onCancel));
}

Future showChangeIconDialog(BuildContext context, String selectedId, {Function onCancel, Function(ImageAsset) onSave}) {
  return showDialog(
      context: context,
      builder: (context) => ChangeImageAssetsDialog(list: assetIconList, selectedId: selectedId, onSave: onSave, onCancel: onCancel));
}


Future<bool> showPinCodeDialog(BuildContext context, Function(String) onDone) async {
  Color primaryColor = Theme.of(context).primaryColor;
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Text('Vui lòng nhập PIN', style: TextStyle(fontSize: 18.0)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: PinCodeTextField(
                  autofocus: true,
                  hideCharacter: true,
                  maskCharacter: "•",
                  highlight: true,
                  highlightColor: ptPrimaryColor(context),
                  defaultBorderColor: HexColor(appBorderColor),
                  hasTextBorderColor: ptPrimaryColor(context),
                  maxLength: 4,
                  onDone: onDone,
                  pinBoxWidth: deviceWidth(context) / 8,
                  pinBoxHeight: 50,
                  wrapAlignment: WrapAlignment.center,
                  pinBoxDecoration:
                  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinBoxRadius: 5,
                  pinTextStyle: ptHeadline(context),
                  pinTextAnimatedSwitcherTransition:
                  ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration:
                  Duration(milliseconds: 300),
                  keyboardType: TextInputType.number
              ))
          ],),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel', style: TextStyle(color: primaryColor)),
                onPressed: () => Navigator.pop(ctx, true)),
//            FlatButton(
//                child: Text(confirmLabel != null ? confirmLabel : 'Ok', style: TextStyle(color: primaryColor)),
//                onPressed: confirmTap != null ? confirmTap : () => Navigator.pop(ctx, true)),
          ],
        );
      });
}


//class TextFieldAlertDialog extends StatelessWidget {
//  TextEditingController _textFieldController = TextEditingController();
//
//  _displayDialog(BuildContext context) async {
//    return showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text('TextField in Dialog'),
//            content: TextField(
//              controller: _textFieldController,
//              decoration: InputDecoration(hintText: "TextField in Dialog"),
//            ),
//            actions: <Widget>[
//              new FlatButton(
//                child: new Text('CANCEL'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              )
//            ],
//          );
//        });
//  }
//}

