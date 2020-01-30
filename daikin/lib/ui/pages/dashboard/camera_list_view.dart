import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CameraListView extends StatefulWidget {
  const CameraListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _CameraListViewState createState() => _CameraListViewState();
}

class _CameraListViewState extends State<CameraListView> with TickerProviderStateMixin {
  ApplicationBloc _appBloc;
  AnimationController animationController;
  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: StreamBuilder<List<Device>>(
        stream: _appBloc.homeBloc.cameraDevicesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
            int index = 0;
            return GridView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data.map((item)
                {
                  final int count = Category.popularCourseList.length > 6 ? 6 : Category.popularCourseList.length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  );
                  index++;
                  animationController.forward();
                  return CameraItemView(
                    callback: () {
                      widget.callBack(item);
                    },
                    device: item,
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ).toList(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.1,
                // childAspectRatio: MediaQuery.of(context).size.height / 680,
              ),
            );
          }
        },
      ),
    );
  }
}

class CameraItemView extends StatelessWidget {
  const CameraItemView({Key key, this.device, this.animationController, this.animation, this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Device device;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor(appColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: GestureDetector(
                onTap: () {
                  callback();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                        child: CachedNetworkImage(
                          imageUrl: device.properties.getCameraThumbPreview,
                          errorWidget: (context, url, err) {
                            return Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(12.0),
                              child: Image.asset('assets/icons/ic_camera.png', color: Colors.black54, fit: BoxFit.cover),);
                          },
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )

//                        Image.network(
//                          'https://s.ftcdn.net/v2013/pics/all/curated/RKyaEDwp8J7JKeZWQPuOVWvkUjGQfpCx_cover_580.jpg',
////                          device.properties.getCameraThumbPreview,
//                          width: double.infinity,
//                          height: double.infinity,
//                          fit: BoxFit.cover,
//                          // color: Colors.blue,
//                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                      child: Text(
                        device.name,
                        textAlign: TextAlign.left,
                        style: ptTitle(context).copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
