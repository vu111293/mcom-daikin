

import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/pages/news/news_detail_page.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  final _newsStream = BehaviorSubject<List<NewsModel>>();

  @override
  void initState() {
    loadNotifications();
    super.initState();
  }


  Future loadNotifications() async {
    // Load data here
    List<NewsModel> items = await BusinessService().getNotifications();
    _newsStream.sink.add(items);
    return Future;
  }

  @override
  void dispose() {
    _newsStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BaseHeaderScreen(
            title: toBeginningOfSentenceCase("Thông báo"),
            isBack: true,
            hideProfile: true,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _newsStream.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Đang tải...'),
                  );
                }

                List<NewsModel> items = snapshot.data;
                if (items == null || items.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Không có thông báo mới'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: loadNotifications,
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        NewsModel news = items[index];
                        return ListTile(
                          onTap: () {
                            Routing().navigate2(context, NewsDetailPage(newsModel: news)).then((value) {
                              loadNotifications();
                            });
                          },
                          title: Text(news.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: news.isUnRead ? Colors.black : Colors.black45)),
                          subtitle: Text(news.body ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: news.isUnRead ? Colors.black54 : Colors.black38)),
                          leading: news.image?.isNotEmpty == true
                              ? Image.network(news.image, width: 24, height: 24)
                              : Image.asset('assets/images/place_notification.jpg', width: 24, height: 24),
                        );
                      }
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
