import 'dart:math';

class Category {
  Category({
    this.title = '',
    this.subTitle = 'Nhấn để tắt và mở cửa',
    this.imagePath = '',
    this.deviceCount = 0,
    this.deviceState = '',
    this.temperature = 0.0,
    this.status = false,
  });

  String title;
  String subTitle;
  int deviceCount;
  String deviceState;
  double temperature;
  String imagePath;
  bool status;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/runningDevices/light.png',
      title: 'Lighting',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/runningDevices/temperature.png',
      title: 'Temperature',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/runningDevices/humidity.png',
      title: 'Humidity',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
  ];
  static List<Category> categoryRooms = <Category>[
    Category(
      imagePath: 'assets/icons/Tu_lanh.png',
      title: 'Kitchen',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Sofa.png',
      title: 'Bedroom',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/TV_01.png',
      title: 'Living room',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Bon_tam.png',
      title: 'Bathroom',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Giay_WC.png',
      title: 'Toilet',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Cua.png',
      title: 'Entrance',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Nha_01.png',
      title: 'Garage',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
  ];
  static List<Category> categoryDevices = <Category>[
    Category(
      imagePath: 'assets/icons/Tuyet.png',
      title: 'Cooling',
      subTitle: 'Nhấn để mở Điều hòa',
      deviceState: Random().nextInt(100).toString() + "°C",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Motion.png',
      title: 'Motion',
      deviceState: '',
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/TV_02.png',
      title: 'TV',
      deviceState: Random().nextInt(100).toString() + "180 W",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Quat.png',
      title: 'Fan',
      deviceState: Random().nextInt(100).toString() + "49 W",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/devices/tree_4.png',
      title: 'Tưới cây',
      deviceState: '',
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Den_ngu.png',
      title: 'Desk lamp',
      deviceState: Random().nextInt(100).toString() + "%",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Cua.png',
      title: 'Cửa chính',
      deviceState: Random().nextInt(3).toString() + 'lv',
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Den_tran.png',
      title: 'Bed Lamp',
      deviceState: Random().nextInt(100).toString() + "%",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/RGB.png',
      title: 'RGB Lamp',
      subTitle: "Điều chỉnh độ sáng: điều chỉnh bằng cách lướt",
      deviceState: Random().nextInt(100).toString() + "%",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Cua_so_02.png',
      title: 'Rèm cửa',
      subTitle: 'Kéo để tắt và mở Rèm cửa',
      deviceState: Random().nextInt(4).toString() + "lv",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Camera.png',
      title: 'Camera',
      deviceState: '',
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
    Category(
      imagePath: 'assets/icons/Siren.png',
      title: 'Siren',
      deviceState: Random().nextInt(5).toString() + "lv",
      temperature: Random().nextDouble() * 100,
      status: Random().nextBool(),
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/hotel/hotel_${Random().nextInt(7)}.png',
      title: 'Living Room ${Random().nextInt(100)}',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
  ];
}
