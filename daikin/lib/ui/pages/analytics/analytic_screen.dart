import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class AnalyticScreen extends StatefulWidget {
  @override
  AnalyticScreenState createState() => AnalyticScreenState();
}

class AnalyticScreenState extends State<AnalyticScreen> with SingleTickerProviderStateMixin {
  final _newsStream = BehaviorSubject<List<NewsModel>>();

  @override
  void initState() {
    preparePage();
    super.initState();
  }


  preparePage() {
    // Load data here
    _newsStream.sink.add([
      NewsModel(title: 'Hệ thống bảo trì 1', body: 'Chúng tôi thành thật xin lỗi vì sự bất tiện này...', image: 'https://png.pngtree.com/element_our/png_detail/20181227/notification-vector-icon-png_295003.jpg', status: 'unread'),
      NewsModel(title: 'Hệ thống bảo trì 1', body: 'Chúng tôi thành thật xin lỗi vì sự bất tiện này...', image: 'https://png.pngtree.com/element_our/png_detail/20181227/notification-vector-icon-png_295003.jpg', status: 'unread'),
      NewsModel(title: 'Hệ thống bảo trì 1', body: 'Chúng tôi thành thật xin lỗi vì sự bất tiện này...', image: 'https://png.pngtree.com/element_our/png_detail/20181227/notification-vector-icon-png_295003.jpg', status: 'unread'),
      NewsModel(title: 'Hệ thống bảo trì 1', body: 'Chúng tôi thành thật xin lỗi vì sự bất tiện này...', image: 'https://png.pngtree.com/element_our/png_detail/20181227/notification-vector-icon-png_295003.jpg', status: 'unread'),
      NewsModel(title: 'Hệ thống bảo trì 1', body: 'Chúng tôi thành thật xin lỗi vì sự bất tiện này...', image: 'https://png.pngtree.com/element_our/png_detail/20181227/notification-vector-icon-png_295003.jpg', status: 'unread'),
      NewsModel(title: 'Hệ thống bảo trì 1', body: 'Chúng tôi thành thật xin lỗi vì sự bất tiện này...', image: 'https://png.pngtree.com/element_our/png_detail/20181227/notification-vector-icon-png_295003.jpg', status: 'unread'),
    ]);

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
            title: toBeginningOfSentenceCase("Lịch sử sự kiện"),
            isBack: true,
            hideProfile: true,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _newsStream.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Đang tải...'),
                  );

                List<NewsModel> items = snapshot.data;
                return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      NewsModel news = items[index];
                      return ListTile(
                        title: Text(news.title),
                        subtitle: Text(news.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                        leading: Image.network(news.image, width: 24, height: 24),
                      );
                    }
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
