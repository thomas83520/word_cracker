import 'package:dio/dio.dart';

class TrouveMotsProvider {
  TrouveMotsProvider();
  final dio = Dio();

  Future<dynamic>? getRandomWord(int count) async {
    final response = await dio.get('https://trouve-mot.fr/api/random/$count');

    return response.data;
  }
}
