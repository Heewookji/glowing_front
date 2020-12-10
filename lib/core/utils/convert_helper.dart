
class ConvertHelper {
  static List<String> dynamicToStringList(dynamic list) {
    List<dynamic> init = list;
    return init.map((s) => s as String).toList();
  }
}
