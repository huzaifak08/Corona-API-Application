import 'package:corona_api/libraries.dart';
import 'package:http/http.dart' as http;

class StatsService {
  Future<WorldStatsModel> fetchWorldStatesData() async {
    final response = await http.get(Uri.parse(AppUrl.WorldStatsApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}
