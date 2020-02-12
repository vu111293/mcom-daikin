import 'package:flutter/material.dart';

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

class DialogExample extends StatefulWidget {
  @override
  _DialogExampleState createState() => new _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  String _text = "initial";
  TextEditingController _c;
  @override
  initState() {
    _c = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(_text),
          new RaisedButton(
            onPressed: () {
              showDialog(
                  child: new Dialog(
                    child: new Column(
                      children: <Widget>[
                        new TextField(
                          decoration: new InputDecoration(hintText: "Update Info"),
                          controller: _c,
                        ),
                        new FlatButton(
                          child: new Text("Save"),
                          onPressed: () {
                            setState(() {
                              this._text = _c.text;
                            });
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                  context: context);
            },
            child: new Text("Show Dialog"),
          )
        ],
      )),
    );
  }
}
