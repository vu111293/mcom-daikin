import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class RoomsListView extends StatefulWidget {
  const RoomsListView({Key key, this.callBack}) : super(key: key);

  final Function(String title) callBack;
  @override
  _RoomsListViewState createState() => _RoomsListViewState();
}

class _RoomsListViewState extends State<RoomsListView> with TickerProviderStateMixin {

  AnimationController animationController;
  ApplicationBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: StreamBuilder<List<Room>>(stream: _appBloc.homeBloc.roomDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else {
          // Todo Please get room models from snapshot.data

          return Container(
            height: deviceHeight(context) * 0.6,
            child: GridView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: List<Widget>.generate(
                Category.categoryRooms.length,
                    (int index) {
                  final int count = Category.categoryRooms.length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      widget.callBack(Category.categoryRooms[index].title);
                    },
                    category: Category.categoryRooms[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: MediaQuery.of(context).size.height / 480,
              ),
            ),
          );
        }
      })
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({Key key, this.category, this.animationController, this.animation, this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;
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
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 8,
              shadowColor: Colors.black26,
              color: Colors.white,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            category.imagePath,
                            width: 27,
                            height: 27,
                            fit: BoxFit.contain,
                            color: ptPrimaryColor(context),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: category.deviceCount % 2 == 0 ? Colors.redAccent : Colors.greenAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 15, 5, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              category.title,
                              textAlign: TextAlign.left,
                              style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                '${category.deviceCount} devices',
                                textAlign: TextAlign.left,
                                style: ptCaption(context).copyWith(color: HexColor(appColor2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
