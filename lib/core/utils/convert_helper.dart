import 'package:glowing_front/core/models/message_room_model.dart';
import 'package:glowing_front/core/models/model.dart';

class ConvertHelper {
  static List<String> mapToStringList(dynamic list) {
    try {
      List<dynamic> init = list;
      return init.map((s) => s as String).toList();
    } catch (e, trace) {
      print(e);
      print(trace);
    }
    throw Exception();
  }

  static Map<String, T> mapToIdModelMap<T>(dynamic json) {
    try {
      Map<dynamic, dynamic> init = json;
      switch (T) {
        case MessageRoomUserInfoModel:
          return _dynamicToIdMessageRoomUserInfoModelMap(init)
              as Map<String, T>;
      }
    } catch (e, trace) {
      print(e);
      print(trace);
    }
    throw Exception();
  }

  static idModelMapToJson<T extends Model>(Map<String, T> modelMap) {
    try {
      return modelMap.map((key, value) => MapEntry(key, value.toJson()));
    } catch (e, trace) {
      print(e);
      print(trace);
    }
    throw Exception();
  }

  static Map<String, MessageRoomUserInfoModel>
      _dynamicToIdMessageRoomUserInfoModelMap(Map<dynamic, dynamic> json) {
    return json.map((key, value) => MapEntry(
        key as String, MessageRoomUserInfoModel.fromMap(value as Map, key)));
  }
}
