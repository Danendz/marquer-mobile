import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/calendar/calendar_overview.dart';
import 'package:marquer/api/models/model_parser.dart';

final getIt = GetIt.instance;

final class CalendarService {
  final api = getIt<ApiService>(instanceName: 'api');

  Future<CalendarOverview> getOverview(String from, String to) async {
    final resp = await api.get<CalendarOverview>(
      '/calendar/overview',
      query: {'from': from, 'to': to},
      fromJsonT: (json) => ModelParser.objectFromJson(json, CalendarOverview.fromJson),
    );
    return resp.data;
  }
}
