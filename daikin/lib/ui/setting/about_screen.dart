import 'package:daikin/ui/customs/base_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BaseHeaderScreen(
                title: toBeginningOfSentenceCase("Giới Thiệu"),
                isBack: true,
                hideProfile: true,
              ),
              Html(
                padding: EdgeInsets.all(16.0),
                data: """
<div id="main_content" class="">
	<div class="heading">
				<a href="">Trang chủ</a>&nbsp;<i class="fa fa-angle-right" aria-hidden="true"></i>&nbsp;<a href="cong-nghe-nha-thong-minh-den-tu-daikin">CÔNG NGHỆ NHÀ THÔNG MINH ĐẾN TỪ DAIKIN </a>
		
			</div>
        <div class="tieude_giua"><div>CÔNG NGHỆ NHÀ THÔNG MINH ĐẾN TỪ DAIKIN </div><span></span></div>
<div class="box_container">
    <div class="content">   	    
        <p style="text-align: center;"><strong><span style="font-size: 18px;"><span style="font-family: helvetica;"><span style="color: rgb(0, 100, 0);">CÔNG NGHỆ NHÀ THÔNG MINH DAIKIN</span></span></span></strong></p>

<p style="text-align: center;"><strong><span style="font-size: 18px;"><span style="font-family: helvetica;"><span style="color: rgb(0, 100, 0);">MỘT QUẢN GIA MƠ ƯỚC</span></span></span></strong></p>

<p style="text-align: center;"><span style="font-size: 20px;"><span style="color: rgb(0, 153, 255);"><strong><span style="font-family: helvetica;">DAIKIN SMART LIVING</span></strong></span></span></p>

<p style="text-align: center;"><br>
&nbsp;</p>

<p style="text-align:center"><img alt="CÔNG TY TNHH LÂM QUANG ĐẠI" height="547" src="https://trungtamdienlanh.vn/upload/images/Smarthome(1).jpg" width="1144"></p>

<p style="text-align: justify;">&nbsp;</p>

<p style="text-align: justify;"><span style="font-family: helvetica; font-size: 16px;">DAIKIN là một trong những nhà sản xuất thiết bị điều hòa không khí lớn nhất thế giới với hơn 90 năm kinh nghiệm tại hơn 150 quốc gia. Daikin không ngừng nghiên cứu và áp dụng công nghệ tiên tiến mang lại các sản phẩm sáng tạo mang nhiều giá trị gia tăng cung cấp giải pháp cho khách hàng, hướng đến một cuộc sống thông minh hơn.</span><br>
&nbsp;</p>

<p><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;"><strong>Nhà thông minh (Daikin Smart Living) công nghệ 4.0 là?</strong></span></span></span></p>

<p><span style="font-size: 16px;"><span style="font-family: helvetica;">Sau sự ra đời của công nghệ 1.0 (phát triển của cơ khí, động cơ hơi nước), công nghệ 2.0 (sản xuất theo dây chuyền, điện), công nghệ 3.0 (phát triển của máy tính, tự động hoá) và ngày nay chúng ta hay nói nhiều đến 4.0, đó là sự phát triển của công nghệ trí tuệ nhân tạo mà nổi bật là trợ lý ảo (Siri (Apple), Google Assistant, Alexa (Amazon) hay Cortana (Microsoft).</span></span><br>
&nbsp;</p>

<p><span style="font-size: 16px;"><span style="font-family: helvetica;"><span style="color: rgb(0, 153, 255);">Daikin Smart Living</span>&nbsp;là giải pháp nhà thông minh với một giao diện duy nhất, hệ thống có thể được tích hợp để điều khiển và giao tiếp qua mạng tới các thiết bị gia dụng và thiết bị điện tử được kết nối ở nhà hoặc đi xa. Công nghệ Daikin Smart Living hứa hẹn mang đến cho bạn không gian sống thoải mái, tiện nghi và hiện đại;&nbsp;ứng dụng thông minh dành cho các dự án: khách sạn, biệt thự, căn hộ cao cấp,...</span></span></p>

<p>&nbsp;</p>

<p style="text-align:center"><img alt="CÔNG TY TNHH LÂM QUANG ĐẠI" height="610" src="https://trungtamdienlanh.vn/upload/images/Slide2.jpg" width="1063"></p>

<p style="text-align: center;"><strong style="color: rgb(0, 100, 0); text-align: center;"><span style="font-family: helvetica; font-size: 16px;">Daikin Smart Living chú ý đến những chi tiết nhỏ nhất mang đến cho bạn sự tiện lợi,&nbsp;sự an tâm trong cuộc sống năng động của bạn</span></strong></p>

<p style="text-align: center;">&nbsp;</p>

<p style="text-align:center"><img alt="CÔNG TY TNHH LÂM QUANG ĐẠI" height="631" src="https://trungtamdienlanh.vn/upload/images/DSMARTHOME-01.jpg" width="1077"></p>

<p style="text-align: justify;">&nbsp;</p>

<p style="text-align: justify;"><span style="color: rgb(0, 100, 0);"><span style="font-size: 18px;"><span style="font-family: helvetica;"><strong>TIỆN NGHI</strong></span></span></span></p>

<p style="text-align: justify;">&nbsp;</p>

<p style="text-align: justify; margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Giao diện điều khiển điện thoại thông minh</span></span></span></p>

<p style="text-align: justify; margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Ứng dụng điện thoại của chúng tôi mang đến và thêm sự an tâm với khả năng kiểm soát và giám sát điều hòa của bạn tại nơi làm việc hoặc ở nhà, biến ngôi nhà của bạn thành một ngôi nhà thông minh.</span></span><br>
&nbsp;</p>

<p style="text-align: justify; margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Chẩn đoán thông minh</span></span></span></p>

<p style="text-align: justify; margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Cung cấp cho bạn dữ liệu hiệu suất và nhắc nhở lỗi hệ thống điều hòa không khí của bạn. Kỹ thuật viên có thể xác định các lỗi nhanh chóng, tiết kiệm thời gian và tiền bạc.</span></span><br>
&nbsp;</p>

<p style="text-align: justify; margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Giám sát điều hòa không khí thông minh</span></span></span></p>

<p style="text-align: justify; margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Có thể theo dõi hệ thống điều hòa không khí của bạn, kiểm tra trạng thái khi không có ai ở nhà.&nbsp;</span></span><span style="font-family: helvetica; font-size: 16px;">Không còn lo lắng về việc bạn quên tắt điều hòa.</span></p>

<p style="text-align: justify; margin-left: 40px;">&nbsp;</p>

<p style="text-align: justify; margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Chất lượng không khí trong nhà</span></span></span></p>

<p style="text-align: justify; margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Máy lọc không khí của Daikin làm sạch không khí bằng công nghệ tinh lọc Active Plasma Ion và Streamer để hạn chế virus, vi khuẩn, chất gây dị ứng và mùi hôi. Tận hưởng không khí sạch và tinh khiết xung quanh với công nghệ lọc không khí 6 lớp và nhắc nhở người dùng bật máy lọc không khí khi chất lượng không khí trong phòng kém.</span></span></p>

<p style="text-align: justify; margin-left: 40px;">&nbsp;</p>

<p><span style="font-size: 20px;"><span style="color: rgb(0, 100, 0);"><strong><span style="font-family: helvetica;">ĐẲNG CẤP</span></strong></span></span></p>

<p>&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Hệ thống giải trí âm thanh &amp; hình ảnh</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Trải nghiệm giải trí nhà thông minh đầy đắm chìm và kết nối với nhau bằng DrosSmartHome. Bạn có thể biến phòng khách của mình thành một rạp hát gia đình tuyệt vời chỉ bằng vài cú nhấp chuột trên điện thoại thông minh.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Ánh sáng</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Bạn không cần phải rời khỏi ghế để chuyển sang vị trí tường. Bạn có thể điều chỉnh độ sáng của đèn theo tâm trạng một cách thoải mái với điện thoại thông minh trên tay.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Rèm cửa</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Không cần thêm dây cáp, không cần phải kéo rèm cửa nặng hoặc những vị trí khó tiếp cận. Hãy thư giãn và điều khiển rèm cửa nhà bạn thông qua điện thoại thông minh của bạn ngay bây giờ, cho phép bạn trải nghiệm sự sang trọng của một ngôi nhà thông minh.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Trợ lý giọng nói</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Với Trợ lý giọng nói đóng vai trò là quản gia cá nhân của bạn. Tích hợp với các thiết bị điện, tự động hóa và bảo mật tại nhà, sử dụng giọng nói của bạn để kích hoạt nhiều thiết bị thông minh khác nhau trong phòng, giúp bạn kiểm soát sự thoải mái và an ninh trong nhà - cộng với sự tiện lợi của an ninh nhiệm vụ như giảm nhiệt độ hoặc tắt đèn mà không cần phải thao tác trực tiếp.</span></span></p>

<p style="margin-left: 40px;">&nbsp;</p>

<p style="text-align:center"><img alt="CÔNG TY TNHH LÂM QUANG ĐẠI" height="735" src="https://trungtamdienlanh.vn/upload/images/smarthome1-01.jpg" width="1033"></p>

<p style="margin-left: 40px;"><br>
&nbsp;</p>

<p style="margin-left: 40px;"><strong style="color: rgb(0, 100, 0); font-size: 20px;"><span style="font-family: helvetica;">AN TOÀN</span></strong></p>

<p style="margin-left: 40px;">&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Khóa điện tử thông minh</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Khóa và mở khóa cửa từ xa trên điện thoại thông minh của bạn từ bất cứ đâu. Bạn cũng có thể kiểm tra khoản vay nếu cửa của bạn bị khóa hoặc mở khóa hoặc thậm chí cho khách vào từ xa.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Camera giám sát</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Bảo vệ người thân của bạn. Bạn có thể giám sát nhà của mình mọi lúc, mọi nơi. Camera giám sát cũng có thể được tích hợp với các thiết bị bảo mật thông minh khác để tăng cường bảo mật tổng thể.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Cảm biến chuyển động</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Phát hiện các chuyển động để kích hoạt các cảnh đặt trước, theo dõi và thông báo trạng thái của những người thân yêu của bạn. Bật/tắt đèn cho phòng tắm để tiết kiệm năng lượng.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Cảm biến cửa &amp; cửa sổ</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Đối với hệ thống an ninh nâng cao, cảm biến cửa và cửa sổ là một lựa chọn tuyệt vời để giám sát và bảo vệ các điểm vào nhà của bạn. Thông báo sẽ được nhận nếu cửa /cửa sổ được mở hoặc đóng, ngăn chặn những nguy hiểm có thể xảy ra với nhà bạn.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Chuông cửa video &amp; Hệ thống liên lạc âm thanh</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Cho dù bạn đang ở nhà hay đi xa, hệ thống liên lạc âm thanh và chuông cửa thông minh cho phép bạn xem và nói chuyện với khách truy cập trên điện thoại thông minh của bạn khi họ đến hoặc khi bưu kiện được giao.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Cảm biến khói</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size:16px;"><span style="font-family:helvetica;">Thiết bị dò khói thông minh sẽ giúp bạn phát hiện kịp thời các sự cố có thể xảy ra như cháy nổ và truyền tín hiệu đến trung tâm báo cháy để kích hoạt báo động, tự động&nbsp;</span></span><span style="font-family: helvetica; font-size: 16px;">cảnh báo bạn trên điện thoại khi phát hiện khói.</span></p>

<p style="margin-left: 40px;">&nbsp;</p>

<p style="text-align:center"><img alt="CÔNG TY TNHH LÂM QUANG ĐẠI" height="617" src="https://trungtamdienlanh.vn/upload/images/smarthome2-01.jpg" width="1045"></p>

<p style="text-align: justify;">&nbsp;</p>

<p style="text-align: justify;"><span style="color: rgb(0, 100, 0);"><strong><span style="font-size: 20px;"><span style="font-family: helvetica;">TIẾT KIỆM NĂNG LƯỢNG</span></span></strong></span></p>

<p style="text-align: justify;">&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Hệ thống thông gió thu hồi nhiệt</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Hệ SUPER MULTI HW của Daikin tăng gấp đôi so với các loại điều hòa không khí thông thường hoạt động như một máy nước nóng bằng cách thu nhiệt thải ra từ dàn nóng và thu hồi nhiệt để tạo ra nước nóng với chi phí tiết kiệm gần như bằng không. Chế độ bật/tắt máy nước nóng và điều chỉnh nhiệt độ nước thông minh bằng điện thoại hỗ trợ khi bạn ở bất cứ đâu. Giúp bạn kiểm soát nhiều hơn đối với mức tiêu thụ và tiết kiệm chi phí tối ưu.</span></span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Hệ thống quản lý năng lượng (HEMS)</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-family: helvetica; font-size: 16px;">HEMS cho phép bạn theo dõi và phân tích mức tiêu thụ năng lượng trong nhà trên điện thoại thông minh của bạn. Điều này sẽ giúp tiết kiệm năng lượng rất lớn và giảm hóa đơn tiền điện của bạn.</span><br>
&nbsp;</p>

<p style="margin-left: 40px;"><span style="color: rgb(0, 153, 255);"><span style="font-size: 16px;"><span style="font-family: helvetica;">Bộ chuyển mạch thông minh</span></span></span></p>

<p style="margin-left: 40px;"><span style="font-size: 16px;"><span style="font-family: helvetica;">Chuyển đổi ổ cắm điện thông thường của bạn sang ổ cắm công tắc thông minh. Bạn có thể bật/tắt thiết bị cùng với việc theo dõi mức tiêu thụ năng lượng của thiết bị.</span></span></p>

<p style="margin-left: 40px;">&nbsp;</p>

<p background-color:="" font-size:="" open="" style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; text-align: center;" text-align:=""><iframe allowfullscreen="" frameborder="0" height="360" src="//www.youtube.com/embed/EWAyL6B430w?rel=0&amp;autoplay=1" width="640"></iframe></p>

<p background-color:="" font-size:="" open="" style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; text-align: center;" text-align:="">&nbsp;</p>

<p background-color:="" font-size:="" open="" style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; text-align: center;" text-align:=""><span style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; font-size: 16px;"><span style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; font-family: helvetica;">---------</span></span></p>

<p background-color:="" font-size:="" open="" style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; text-align: center;" text-align:="">&nbsp;</p>

<p background-color:="" font-size:="" open="" style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; text-align: center;" text-align:=""><span style="color:#006400;"><span style="font-size:16px;"><span style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none;"><span style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none;"><strong style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none;"><span style="margin: 0px; padding: 0px; box-sizing: border-box; outline: none; font-family: helvetica;">&gt;&gt; HOTLINE:&nbsp; 0913 700 102 | Email: dienlanh.lqd@gmail.com</span></strong></span></span></span></span></p>
   
                
        <div class="addthis_native_toolbox" data-url="https://trungtamdienlanh.vn/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=7" data-title="CÔNG NGHỆ NHÀ THÔNG MINH ĐẾN TỪ DAIKIN " data-description="DAIKIN là một trong những nhà sản xuất thiết bị điều hòa không khí lớn nhất thế giới với hơn 90 năm kinh nghiệm tại hơn 150 quốc gia. Daikin không ngừng nghiên cứu và áp dụng công nghệ tiên tiến mang lại các sản phẩm sáng tạo mang nhiều giá trị gia tăng cung cấp giải pháp cho khách hàng, hướng đến một cuộc sống thông minh hơn."><b>Chia sẻ: </b><div id="atstbx" class="at-share-tbx-element at-share-tbx-native addthis_default_style addthis_20x20_style addthis-smartlayers addthis-animated at4-show"><a class="addthis_button_facebook_like at_native_button at300b" fb:like:layout="button_count"><div class="fb-like fb_iframe_widget" data-layout="button_count" data-show_faces="false" data-share="false" data-action="like" data-width="90" data-height="25" data-font="arial" data-href="https://trungtamdienlanh.vn/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=7" data-send="false" style="height: 25px;" fb-xfbml-state="rendered" fb-iframe-plugin-query="action=like&amp;app_id=&amp;container_width=0&amp;font=arial&amp;height=25&amp;href=https%3A%2F%2Ftrungtamdienlanh.vn%2Fcong-nghe-nha-thong-minh-den-tu-daikin%26p%3D7&amp;layout=button_count&amp;locale=vi_VN&amp;sdk=joey&amp;send=false&amp;share=false&amp;show_faces=false&amp;width=90"><span style="vertical-align: bottom; width: 76px; height: 20px;"><iframe name="f231a0bd661308" width="90px" height="25px" title="fb:like Facebook Social Plugin" frameborder="0" allowtransparency="true" allowfullscreen="true" scrolling="no" allow="encrypted-media" src="https://www.facebook.com/v2.8/plugins/like.php?action=like&amp;app_id=&amp;channel=https%3A%2F%2Fstaticxx.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D45%23cb%3Df28f080735d8d54%26domain%3Dtrungtamdienlanh.vn%26origin%3Dhttps%253A%252F%252Ftrungtamdienlanh.vn%252Ff3832a690d990f8%26relation%3Dparent.parent&amp;container_width=0&amp;font=arial&amp;height=25&amp;href=https%3A%2F%2Ftrungtamdienlanh.vn%2Fcong-nghe-nha-thong-minh-den-tu-daikin%26p%3D7&amp;layout=button_count&amp;locale=vi_VN&amp;sdk=joey&amp;send=false&amp;share=false&amp;show_faces=false&amp;width=90" style="border: none; visibility: visible; width: 76px; height: 20px;" class=""></iframe></span></div></a><a class="addthis_button_facebook_share at_native_button at300b" fb:share:layout="button_count"><div class="fb-share-button fb_iframe_widget" data-layout="button_count" data-href="https://trungtamdienlanh.vn/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=7" style="height: 25px;" fb-xfbml-state="rendered" fb-iframe-plugin-query="app_id=&amp;container_width=4&amp;href=https%3A%2F%2Ftrungtamdienlanh.vn%2Fcong-nghe-nha-thong-minh-den-tu-daikin%26p%3D7&amp;layout=button_count&amp;locale=vi_VN&amp;sdk=joey"><span style="vertical-align: bottom; width: 86px; height: 20px;"><iframe name="f3653d0807ea88c" width="1000px" height="1000px" title="fb:share_button Facebook Social Plugin" frameborder="0" allowtransparency="true" allowfullscreen="true" scrolling="no" allow="encrypted-media" src="https://www.facebook.com/v2.8/plugins/share_button.php?app_id=&amp;channel=https%3A%2F%2Fstaticxx.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D45%23cb%3Df12f0cae8ba582c%26domain%3Dtrungtamdienlanh.vn%26origin%3Dhttps%253A%252F%252Ftrungtamdienlanh.vn%252Ff3832a690d990f8%26relation%3Dparent.parent&amp;container_width=4&amp;href=https%3A%2F%2Ftrungtamdienlanh.vn%2Fcong-nghe-nha-thong-minh-den-tu-daikin%26p%3D7&amp;layout=button_count&amp;locale=vi_VN&amp;sdk=joey" style="border: none; visibility: visible; width: 86px; height: 20px;" class=""></iframe></span></div></a><a class="addthis_button_facebook_send at_native_button at300b"><div class="fb-send" data-href="https://trungtamdienlanh.vn/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=7" data-type="box_count" style="height: 25px;"></div></a><a class="addthis_button_google_plusone at_native_button"></a><a class="addthis_counter addthis_pill_style at_native_button" href="#" style="display: inline-block;"><a class="atc_s addthis_button_compact">Chia sẻ<span></span></a><a class="addthis_button_expanded" target="_blank" title="Thêm..." href="#"></a></a><div class="atclear"></div></div></div>    

           
        <div class="othernews">
             <div class="cactinkhac"></div>
             <ul class="phantrang">
                                    <li><a href="nhieu-nguoi-luon-lua-chon-may-lanh-vrv-cho-nha-cao-tang" title="Nhiều người luôn lựa chọn máy lạnh VRV cho nhà cao tầng">Nhiều người luôn lựa chọn máy lạnh VRV cho nhà cao tầng</a> (07.02.2017)</li>
                                    <li><a href="chao-he-moi-cung-voi-may-lanh-trung-tam" title="Chào hè mới cùng với máy lạnh trung tâm">Chào hè mới cùng với máy lạnh trung tâm</a> (03.02.2017)</li>
                                    <li><a href="loi-ich-cua-he-thong-may-lanh-vrv" title="Lợi ích của hệ thống máy lạnh vrv">Lợi ích của hệ thống máy lạnh vrv</a> (24.01.2017)</li>
                                    <li><a href="quy-trinh-lap-dat-may-lanh-trung-tam-daikin-vrv" title="Quy trình lắp đặt máy lạnh trung tâm daikin vrv">Quy trình lắp đặt máy lạnh trung tâm daikin vrv</a> (23.01.2017)</li>
                                    <li><a href="dac-diem-noi-bat-cua-may-lanh-trung-tam-vrv" title="Đặc điểm nổi bật của máy lạnh trung tâm VRV">Đặc điểm nổi bật của máy lạnh trung tâm VRV</a> (21.01.2017)</li>
                                    <li><a href="may-lanh-vrv-duoc-su-dung-nhieu-tai-cac-cao-oc" title="Máy lạnh VRV được sử dụng nhiều tại các cao ốc">Máy lạnh VRV được sử dụng nhiều tại các cao ốc</a> (20.01.2017)</li>
                                    <li><a href="may-lanh-trung-tam-vrv-iv-s-cho-can-ho" title=" Máy lạnh trung tâm VRV IV S cho căn hộ"> Máy lạnh trung tâm VRV IV S cho căn hộ</a> (19.01.2017)</li>
                                    <li><a href="nhung-the-manh-cua-may-lanh-trung-tam-vrv" title="Những thế mạnh của máy lạnh trung tâm vrv">Những thế mạnh của máy lạnh trung tâm vrv</a> (18.01.2017)</li>
                             </ul> 
             <div class="pagination"><ul class="pages"><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin" class="left">First</a></li><li></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=2">2</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=3">3</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=4">4</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=5">5</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=6">6</a></li><li><a href="#" class="active">7</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=8">8</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=9">9</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=10">10</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=11">11</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=12">12</a></li><li><a href="https://trungtamdienlanh.vn:443/cong-nghe-nha-thong-minh-den-tu-daikin&amp;p=13" class="right">End</a></li></ul></div> 
        </div><!--.othernews-->
        
             
    </div><!--.content-->
</div><!--.box_container-->
             </div>""",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
