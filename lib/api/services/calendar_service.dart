import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/calendar/calendar_overview.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/create_countdown_request.dart';
import 'package:marquer/api/models/calendar/update_countdown_request.dart';
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

  Future<List<Countdown>> getCountdowns() async {
    final resp = await api.get<List<Countdown>>(
      '/calendar/countdowns',
      fromJsonT: (json) => ModelParser.listFromJson(json, Countdown.fromJson),
    );
    return resp.data;
  }

  Future<Countdown> createCountdown(CreateCountdownRequest request) async {
    final resp = await api.post<Countdown>(
      '/calendar/countdowns',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Countdown.fromJson),
    );
    return resp.data;
  }

  Future<Countdown> updateCountdown(String id, UpdateCountdownRequest request) async {
    final resp = await api.put<Countdown>(
      '/calendar/countdowns/$id',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Countdown.fromJson),
    );
    return resp.data;
  }

  Future<void> deleteCountdown(String id) async {
    await api.delete('/calendar/countdowns/$id');
  }
}
