import 'dart:async';
import 'dart:io';

import 'package:daikin/apis/net/image_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/customs/pic_swiper.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ImagePickerWidget extends StatefulWidget {
  final double size;
  final String resourceUrl;
  final BuildContext context;
  final bool circle;
  final bool isEdit;
  final bool isRemove;
  final bool avatar;
  final Function onClick;
  final bool overrideBkg;

  ImagePickerWidget(
      {Key key,
      this.context,
      this.size = 50,
      this.resourceUrl,
      this.circle = false,
      this.isEdit = false,
      this.isRemove = false,
      this.avatar = false,
      this.onFileChanged,
      this.onClick,
      this.overrideBkg = true})
      : super(key: key);
  final Function(String, String) onFileChanged;

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File image;

  popupAlert() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(
                  'Máy ảnh',
                  style: ptTitle(context),
                ),
                onTap: imageSelectorCamera,
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(
                  'Thư viện ảnh',
                  style: ptTitle(context),
                ),
                onTap: imageSelectorGallery,
              )
            ],
          );
        });
  }

  popup2(String url) {
    Routing()
        .navigate2(context, PicSwiper(0, <PicSwiperItem>[PicSwiperItem(url)]));
  }

  Widget uploadExtraInfo() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
          Radius.circular(widget.circle ? widget.size / 2 : 5.0)),
      child: GestureDetector(
        onTap: () {
          widget.resourceUrl != null &&
                  widget.resourceUrl != '' &&
                  widget.resourceUrl.contains("http")
              ? popup2(widget.resourceUrl)
              : {};
        },
        child: widget.resourceUrl != null &&
                widget.resourceUrl != '' &&
                widget.resourceUrl.contains("http")
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                width: widget.size,
                height: widget.size,
                imageUrl: widget.resourceUrl,
                placeholder: (context, url) => Center(
                  child: Container(
                    width: widget.size / 2,
                    height: widget.size / 2,
                    child: CircularProgressIndicator(
                        backgroundColor:
                            ptPrimaryColor(context).withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ptPrimaryColor(context).withOpacity(0.3))),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : image == null
                ? Container()
                : Image.file(
                    image,
                    fit: BoxFit.cover,
                    width: widget.size,
                    height: widget.size,
                  ),
      ),
    );
  }

  _handleUploadImage(localImage) async {
    var image0 = image;
    showWaitingDialog(context, message: "Đang tải ảnh lên...");
    String link =
        await ImageService().uploadImageToImgur(localImage).then((onValue) {
      print('dasd $onValue');
      if (widget.onFileChanged != null) {
        widget.onFileChanged(onValue, 'image');
      }
      Navigator.pop(context);
    }).catchError((onError) {
      Navigator.pop(context);
      if (widget.overrideBkg) {
        setState(() {
          image = image0;
        });
      }
      Alert(context: context, title: "", desc: "Cập nhật ảnh thất bại").show();
    });
    print('phat update link ảnh nè: $link');
    if (localImage != null) {
      print("You selected gallery image : " + localImage.path);
      if (widget.overrideBkg) {
        setState(() {
          image = localImage;
        });
      }
    }
  }

  //display image selected from camera
  Future imageSelectorCamera() async {
    try {
      Navigator.pop(context);
      var cameraFile = await ImagePicker.pickImage(
          source: ImageSource.camera,
          maxWidth: 500.0,
          maxHeight: 500.0,
          imageQuality: 80);
      _handleUploadImage(cameraFile);
    } catch(e) {
      print(e);
      showAlertDialog(context, 'Xãy ra lỗi khi tải ảnh. ${e.toString()}');
    }
  }

  //display image selected from gallery
  Future imageSelectorGallery() async {
    Navigator.pop(context);
    var galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500.0,
        maxHeight: 500.0,
        imageQuality: 80);
    _handleUploadImage(galleryFile);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.avatar) {
      return ClipOval(
        child: GestureDetector(
          onTap: () {
            widget.resourceUrl != null &&
                    widget.resourceUrl != '' &&
                    widget.resourceUrl.contains("http")
                ? popup2(widget.resourceUrl)
                : {};
          },
          child:
              widget.resourceUrl != null && widget.resourceUrl.contains("http")
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: widget.size,
                      height: widget.size,
                      imageUrl: widget.resourceUrl,
                      placeholder: (context, url) => Center(
                        child: Container(
                          width: widget.size / 2,
                          height: widget.size / 2,
                          child: CircularProgressIndicator(
                              backgroundColor:
                                  ptPrimaryColor(context).withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ptPrimaryColor(context).withOpacity(0.3))),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : image == null
                      ? Container()
                      : Image.file(
                          image,
                          fit: BoxFit.cover,
                          width: widget.size,
                          height: widget.size,
                        ),
        ),
      );
    } else {
      return Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: ptPrimaryColor(context).withOpacity(0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.circle ? widget.size : 5.0),
          ),
          border: Border.all(color: HexColor('#fafafa')),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          overflow: Overflow.clip,
          fit: StackFit.expand,
          children: <Widget>[
            uploadExtraInfo(),
            widget.isEdit
                ? GestureDetector(
                    onTap: popupAlert,
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.circle ? widget.size : 5.0),
                        ),
                        border: Border.all(color: HexColor('#fafafa')),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: widget.size * 0.3,
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            widget.isRemove
                ? Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.circle ? widget.size : 5.0),
                      ),
                      border: Border.all(color: HexColor('#fafafa')),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.remove_circle,
                        size: widget.size * 0.3,
                        color: Colors.redAccent,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      );
    }
  }
}
