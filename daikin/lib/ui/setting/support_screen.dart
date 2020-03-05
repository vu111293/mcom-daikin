import 'package:daikin/ui/customs/base_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BaseHeaderScreen(
                title: "Hỗ trợ".toUpperCase(),
                isBack: true,
                hideProfile: true,
              ),
              Html(
                padding: EdgeInsets.all(16.0),
                data: """
   <div class="tab-pane call-center active" id="tab-call-center"><div class="row summary"><div class="col-xs-12 col-lg-offset-1 col-lg-10 text-center"><h1 class="text-center">Tổng đài</h1><p class="text-center">Tại tổng đài tiếp nhận cuộc gọi (miễn phí) của Daikin Việt Nam, đội ngũ nhân viên tận tâm sẽ mang đến cho khách hàng sự hỗ trợ tốt nhất đảm bảo giải quyết thông suốt các vấn đề và đáp ứng mọi nhu cầu của khách hàng. Chúng tôi luôn sẵn sàng tiếp nhận cuộc gọi của quý khách.</p><img src="https://www.daikin.com.vn/assets/images/call-center.png" alt="call center"></div></div><div class="row open-hours"><div class="col-xs-12"><h2>Thời gian hoạt động</h2><div class="item"><p>- Thứ 2 - Thứ 6: từ 08:00 đến 12:00 và từ 13:00 đến 17:00</p><p>- Thứ 7: từ 08:00 đến 12:00</p><p>- Chủ Nhật &amp; ngày lễ: nghỉ</p></div><br><h2>Giờ làm việc trong mùa cao điểm năm 2017</h2><div class="item"><p>- Tổng đài tiếp nhận cuộc gọi: Từ 07:30 đến 18:30.</p><p>- Đội ngũ kỹ thuật viên dịch vụ: Từ 08:00 đến 19:00.</p><p>- Chủ Nhật &amp; ngày lễ: nghỉ</p></div><br><h2>Mùa cao điểm được áp dụng:</h2><div class="item"><p>- Khu vực Phía Nam &amp; Miền Trung: Từ 02/04 đến 30/06/2018.</p><p>- Khu vực Phía Bắc : Từ 02/05 đến 30/07/2018.</p></div><br><h2>Chúng tôi cung cấp thông tin về</h2><div class="item"><p>- Dịch vụ bảo hành, sửa chữa</p><p>- Hỗ trợ kỹ thuật</p><p>- Thông tin phụ tùng</p><p>- Dịch vụ bảo trì</p></div></div></div></div>
  """,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
