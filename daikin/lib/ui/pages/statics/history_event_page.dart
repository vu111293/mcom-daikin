import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class HistoryEventPage extends StatefulWidget {
  HistoryEventPage({Key key}) : super(key: key);

  @override
  _HistoryEventPageState createState() => _HistoryEventPageState();
}

class _HistoryEventPageState extends State<HistoryEventPage> {

  final _historyDataSubject = BehaviorSubject<List<HistoryEventModel>>();


  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    _historyDataSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_backspace,
            color: ptPrimaryColor(context),
            size: 36.0,
          ),
        ),
        title: Text(
          "Lịch sử sự kiện",
          style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: StreamBuilder<List<HistoryEventModel>>(
          stream: _historyDataSubject.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container(); // please show empty text here
            return buildTimelineModel(TimelinePosition.Center, snapshot.data);
          },
        ),
      ),
    );
  }

  buildTimelineModel(TimelinePosition position, List<HistoryEventModel> items) => Timeline.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          TextAlign textAlign = i % 2 == 0 ? TextAlign.left : TextAlign.right;
          return TimelineModel(
            Card(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: i % 2 == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    i % 2 == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.access_alarms,
                                size: 28,
                              ),
                              // Image.network(
                              //   item.icon,
                              //   width: 28,
                              //   height: 28,
                              //   fit: BoxFit.contain,
                              // ),
                              Text(
                                'P.Khách',
                                // item.deviceID.toString(),
                                style: ptBody1(context).copyWith(),
                                textAlign: textAlign,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'P.Khách',
                                // item.deviceID.toString(),
                                style: ptBody1(context).copyWith(),
                                textAlign: textAlign,
                              ),
                              Icon(
                                Icons.access_alarms,
                                size: 28,
                              ),
                              // Image.network(
                              //   item.icon,
                              //   width: 28,
                              //   height: 28,
                              //   fit: BoxFit.contain,
                              // ),
                            ],
                          ),
                    SizedBox(height: 8.0),
                    Text(DateFormat.Hms().format(DateTime.fromMillisecondsSinceEpoch(item.timestamp)).toString(), style: ptBody2(context)),
                    SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: i % 2 == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Monion_PK',
                          // item.deviceID.toString(),
                          style: ptBody1(context).copyWith(color: ptPrimaryColor(context)),
                          textAlign: textAlign,
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          child: RichText(
                              textAlign: textAlign,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Breached' + " > ",
                                  style: ptBody2(context).copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'Safe',
                                  style: ptBody2(context).copyWith(fontWeight: FontWeight.bold),
                                )
                              ])),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    )
                  ],
                ),
              ),
            ),
            position: i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
            isFirst: i == 0,
            isLast: i == historyEventModel.length,
            iconBackground: ptPrimaryColor(context),
            icon: Icon(
              Icons.remove_red_eye,
              color: i % 2 == 0 ? Colors.transparent : Colors.white,
            ),
          );
        },
        iconSize: 10.5,
        lineColor: HexColor(appBorderColor),
        physics: position == TimelinePosition.Left ? ClampingScrollPhysics() : BouncingScrollPhysics(),
        position: position,
      );

  Future _loadData() async {
     List<HistoryEventModel> items = await BusinessService().fetchHistoryEventList();
     _historyDataSubject.sink.add(items);
     return Future;
  }
}
