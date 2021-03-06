import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView> with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
            return Container(
              height: deviceHeight(context) * 0.6,
              child: GridView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List<Widget>.generate(
                  Category.popularCourseList.length,
                  (int index) {
                    final int count = Category.popularCourseList.length;
                    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController.forward();
                    return CategoryView(
                      callback: () {
                        widget.callBack();
                      },
                      category: Category.popularCourseList[index],
                      animation: animation,
                      animationController: animationController,
                    );
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: MediaQuery.of(context).size.height / 680,
                ),
              ),
            );
          }
        },
      ),
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
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#F8FAFB'),
                // color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.asset(
                        category.imagePath,
                        fit: BoxFit.cover,
                        height: 115,
                        // color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                      child: Text(
                        category.title,
                        textAlign: TextAlign.left,
                        style: ptSubtitle(context),
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
