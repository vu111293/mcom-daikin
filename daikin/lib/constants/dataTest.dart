import 'dart:math';

class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.deviceCount = 0,
    this.temperature = 0.0,
  });

  String title;
  int deviceCount;
  double temperature;
  String imagePath;

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
      title: 'Kitchen',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Muc_tieu.png',
      title: 'Bedroom',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/TV_02.png',
      title: 'Living room',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Quat.png',
      title: 'Bathroom',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Den_tran.png',
      title: 'Toilet',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Den_ngu.png',
      title: 'Entrance',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
    ),
    Category(
      imagePath: 'assets/icons/Cua_so_02.png',
      title: 'Garage',
      deviceCount: Random().nextInt(100),
      temperature: Random().nextDouble() * 100,
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
