import 'package:word_cracker/data/trouve_mots_provider.dart';

class GameRepository {
  final TrouveMotsProvider trouveMotsProvider;

  GameRepository({required this.trouveMotsProvider});

  Future<List<String>> getRandomWord(int count) async {
    List<dynamic> list = await trouveMotsProvider.getRandomWord(count);
    return list.map((map) => map['name'].toString()).toList();
  }

  Future<List<String>> getWordFromCategory(int categoryId, int count) async {
    return [''];
  }
}
