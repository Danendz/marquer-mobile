import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/model_parser.dart';
import 'package:marquer/api/models/study/complete_study_session_request.dart';
import 'package:marquer/api/models/study/store_study_session_request.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/study_stats.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/upsert_study_subject_request.dart';
import 'package:marquer/api/models/study/user_study_settings.dart';

final getIt = GetIt.instance;

final class StudyService {
  final api = getIt<ApiService>(instanceName: 'api');

  // Subjects
  Future<List<StudySubject>> getSubjects() async {
    final resp = await api.get<List<StudySubject>>(
      '/study/subjects',
      fromJsonT: (json) => ModelParser.listFromJson(json, StudySubject.fromJson),
    );
    return resp.data;
  }

  Future<StudySubject> createSubject(UpsertStudySubjectRequest request) async {
    final resp = await api.post<StudySubject>(
      '/study/subjects',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, StudySubject.fromJson),
    );
    return resp.data;
  }

  Future<StudySubject> updateSubject(
    int id,
    UpsertStudySubjectRequest request,
  ) async {
    final resp = await api.put<StudySubject>(
      '/study/subjects/$id',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, StudySubject.fromJson),
    );
    return resp.data;
  }

  Future<void> deleteSubject(int id) async {
    await api.delete('/study/subjects/$id');
  }

  // Sessions
  Future<List<StudySession>> getSessions({
    String? status,
    int? studySubjectId,
    String? dateFrom,
    String? dateTo,
  }) async {
    final query = <String, dynamic>{};
    if (status != null) query['status'] = status;
    if (studySubjectId != null) query['study_subject_id'] = studySubjectId;
    if (dateFrom != null) query['date_from'] = dateFrom;
    if (dateTo != null) query['date_to'] = dateTo;

    final resp = await api.get<List<StudySession>>(
      '/study/sessions',
      query: query.isNotEmpty ? query : null,
      fromJsonT: (json) => ModelParser.listFromJson(json, StudySession.fromJson),
    );
    return resp.data;
  }

  Future<StudySession> createSession(StoreStudySessionRequest request) async {
    final resp = await api.post<StudySession>(
      '/study/sessions',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, StudySession.fromJson),
    );
    return resp.data;
  }

  Future<StudySession> updateSession(int id, Map<String, dynamic> data) async {
    final resp = await api.put<StudySession>(
      '/study/sessions/$id',
      body: data,
      fromJsonT: (json) => ModelParser.objectFromJson(json, StudySession.fromJson),
    );
    return resp.data;
  }

  Future<StudySession> completeSession(
    int id,
    CompleteStudySessionRequest request,
  ) async {
    final resp = await api.post<StudySession>(
      '/study/sessions/$id/complete',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, StudySession.fromJson),
    );
    return resp.data;
  }

  Future<StudySession> cancelSession(int id) async {
    final resp = await api.post<StudySession>(
      '/study/sessions/$id/cancel',
      body: {},
      fromJsonT: (json) => ModelParser.objectFromJson(json, StudySession.fromJson),
    );
    return resp.data;
  }

  Future<StudyStats> getStats() async {
    final resp = await api.get<StudyStats>(
      '/study/sessions/stats',
      fromJsonT: (json) => ModelParser.objectFromJson(json, StudyStats.fromJson),
    );
    return resp.data;
  }

  // Settings
  Future<UserStudySettings> getSettings() async {
    final resp = await api.get<UserStudySettings>(
      '/study/settings',
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UserStudySettings.fromJson),
    );
    return resp.data;
  }

  Future<UserStudySettings> upsertSettings(UserStudySettings settings) async {
    final resp = await api.put<UserStudySettings>(
      '/study/settings',
      body: settings,
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UserStudySettings.fromJson),
    );
    return resp.data;
  }
}
