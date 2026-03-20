import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/api/services/notes_service.dart';
import 'package:marquer/api/services/auth_service.dart';
import 'package:marquer/api/services/update_service.dart';

class MockTasksService extends Mock implements TasksService {}

class MockCalendarService extends Mock implements CalendarService {}

class MockStudyService extends Mock implements StudyService {}

class MockNotesService extends Mock implements NotesService {}

class MockAuthService extends Mock implements AuthService {}

class MockUpdateService extends Mock implements UpdateService {}
