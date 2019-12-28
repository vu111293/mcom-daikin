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
