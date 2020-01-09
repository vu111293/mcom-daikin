class DeviceDataTest {
  String title;
  List<Devices> subDevices;

  DeviceDataTest({this.title, this.subDevices});

  static List<DeviceDataTest> deviceDataList = <DeviceDataTest>[
    DeviceDataTest(title: "Living room", subDevices: [
      Devices(name: 'Điều hòa', deviceState: true),
      Devices(name: 'Thiết bị tưới cây', deviceState: true),
      Devices(name: 'Cảm biến', deviceState: false),
      Devices(name: 'Camera', deviceState: true),
    ]),
    DeviceDataTest(title: "Bedroom", subDevices: [
      Devices(name: 'Điều hòa', deviceState: true),
      Devices(name: 'Thiết bị tưới cây', deviceState: false),
      Devices(name: 'Cảm biến', deviceState: true),
      Devices(name: 'Camera', deviceState: false),
    ]),
    DeviceDataTest(title: "Kitchen", subDevices: [
      Devices(name: 'Điều hòa', deviceState: false),
      Devices(name: 'Thiết bị tưới cây', deviceState: true),
      Devices(name: 'Cảm biến', deviceState: true),
      Devices(name: 'Camera', deviceState: true),
    ]),
    DeviceDataTest(title: "Bathroom floor 1", subDevices: [
      Devices(name: 'Điều hòa', deviceState: true),
      Devices(name: 'Thiết bị tưới cây', deviceState: true),
      Devices(name: 'Cảm biến', deviceState: true),
      Devices(name: 'Camera', deviceState: true),
    ]),
    DeviceDataTest(title: "Bathroom floor 2", subDevices: [
      Devices(name: 'Điều hòa', deviceState: false),
      Devices(name: 'Thiết bị tưới cây', deviceState: false),
      Devices(name: 'Cảm biến', deviceState: false),
      Devices(name: 'Camera', deviceState: false),
    ]),
  ];
}

class Devices {
  String name;
  bool deviceState;

  Devices({this.name, this.deviceState});
}
