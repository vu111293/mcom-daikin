import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/image_service.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage {
  void uploadImage(BuildContext context, Function cb) async {
    var cameraFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 1000.0, maxHeight: 1000.0);
    _handleUploadImage(context, cameraFile, cb);
  }

  _handleUploadImage(BuildContext context, localImage, Function cb) async {
    // var image0 = image;
    showWaitingDialog(context, message: "Đang tải ảnh lên...");
    String link =
        await ImageService().uploadImageToImgur(localImage).then((onValue) {
      print('dasd $onValue');
      Navigator.pop(context);
      cb(onValue);
      BotToast.showText(text: "Cập nhật ảnh thành công");
    }).catchError((onError) {
      Navigator.pop(context);
      BotToast.showText(text: "Cập nhật ảnh thất bại");
    });
    // print('phat update link ảnh nè: $link');
    // if (localImage != null) {
    //   print("You selected gallery image : " + localImage.path);
    // setState(() {
    //   image = localImage;
    // });
  }
}
