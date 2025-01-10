import 'package:dio/dio.dart';

import '../models/model.dart';

class Services {
  final dio = Dio();

  Future<List<Children>?> fetchData() async {
    var response = await dio
        .get("https://run.mocky.io/v3/87ea2311-cc37-4c12-8236-f6b8de8f8d48");

    if (response.statusCode == 200) {
      final data = Children.fromJson(response.data);
      return data.children;
    } else {
      return null;
    }
  }
}
