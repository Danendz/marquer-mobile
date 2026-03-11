import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/calendar/calendar_overview.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/create_countdown_request.dart';
import 'package:marquer/api/models/calendar/create_plan_request.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/api/models/calendar/update_countdown_request.dart';
import 'package:marquer/api/models/calendar/update_plan_request.dart';
import 'package:marquer/api/models/calendar/week_data.dart';
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

  // Plans

  Future<List<Plan>> getPlans() async {
    final resp = await api.get<List<Plan>>(
      '/calendar/plans',
      fromJsonT: (json) => ModelParser.listFromJson(json, Plan.fromJson),
    );
    return resp.data;
  }

  Future<Plan> createPlan(CreatePlanRequest request) async {
    final resp = await api.post<Plan>(
      '/calendar/plans',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Plan.fromJson),
    );
    return resp.data;
  }

  Future<Plan> updatePlan(String id, UpdatePlanRequest request) async {
    final resp = await api.put<Plan>(
      '/calendar/plans/$id',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Plan.fromJson),
    );
    return resp.data;
  }

  Future<void> deletePlan(String id) async {
    await api.delete('/calendar/plans/$id');
  }

  Future<List<PlanForDate>> getPlansForDate(String date) async {
    final resp = await api.get<List<PlanForDate>>(
      '/calendar/plans/for-date',
      query: {'date': date},
      fromJsonT: (json) => ModelParser.listFromJson(json, PlanForDate.fromJson),
    );
    return resp.data;
  }

  Future<WeekData> getWeekData(String from, String to) async {
    final resp = await api.get<WeekData>(
      '/calendar/week',
      query: {'from': from, 'to': to},
      fromJsonT: (json) => ModelParser.objectFromJson(json, WeekData.fromJson),
    );
    return resp.data;
  }

  Future<bool> togglePlanTaskCompletion(String planTaskId, String date) async {
    final resp = await api.post<Map<String, dynamic>>(
      '/calendar/plan-tasks/$planTaskId/toggle?date=$date',
      fromJsonT: (json) => json as Map<String, dynamic>,
    );
    return resp.data['is_completed'] as bool;
  }
}
