import 'package:mocktail/mocktail.dart';
import 'package:marquer/stores/auth_store.dart';
import 'package:marquer/stores/user_store.dart';

class MockAuthStore extends Mock implements AuthStore {}

class MockUserStore extends Mock implements UserStore {}
