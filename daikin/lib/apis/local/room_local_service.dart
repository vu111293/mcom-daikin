

import 'dart:convert';

import 'package:daikin/apis/local/local_setting.dart';
import 'package:daikin/models/business_models.dart';

class RoomLocalService {

  static RoomLocalService _instance;

  static RoomLocalService get instance {
    if (_instance == null) _instance = RoomLocalService();
    return _instance;
  }

  List<RoomConfig> _configs = [];
  List<ImageAsset> _coverAssets = [];
  LocalSetting _localSetting = LocalSetting();

  List<ImageAsset> get coverAssets => _coverAssets;

  Future loadConfig() async {
    String raw = await _localSetting.getRoomConfig();
    if (raw?.isNotEmpty == true) {
      List items = json.decode(raw);
      _configs = items.map((item) => RoomConfig.fromJson(item)).toList();
    }

    String assetsRaw = await _localSetting.getCoverAssets();
    if (assetsRaw?.isNotEmpty == true) {
      List assetItems = json.decode(assetsRaw);
      _coverAssets = assetItems.map((item) => ImageAsset.fromJson(item)).toList();
    }
    return Future;
  }

  void updateRoomConfig(RoomConfig conf) {
    _configs.removeWhere((item) => item.roomId == conf.roomId);
    _configs.add(conf);
    String raw = json.encode(_configs);
    _localSetting.saveRoomConfig(raw);
  }

  void addCoverAsset(ImageAsset image) {
    _coverAssets.add(image);
    String raw = json.encode(_coverAssets);
    _localSetting.saveCoverAssets(raw);
  }

  RoomConfig getConfig(int roomId) {
    RoomConfig conf = _configs.firstWhere((item) => item.roomId == roomId, orElse: () => null);
    if (conf == null) {
      return RoomConfig(roomId: roomId, name: '', cover: '01', icon: '01');
    }
    return conf;
  }

  void cleanConfig() {

  }
}