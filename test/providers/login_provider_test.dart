import 'package:ecommerce/provider/login_provider.dart';
import 'package:ecommerce/provider/repositories/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  MockLoginRepository mockLoginRepository;
  LoginProvider loginProvider;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginProvider = LoginProvider(loginRepository: mockLoginRepository);
  });

  group("Login :", () {
    test("If email and password is correct, return true", () async {
      final String email = "test@test.com";
      final String password = "password";

      when(mockLoginRepository.login(email: email, password: password))
          .thenAnswer((_) async => true);

      bool result = await loginProvider.login(email: email, password: password);

      verify(mockLoginRepository.login(email: email, password: password));

      expect(result, true);
    });

    test("If email and password is incorrect, return false", () async {
      final String email = "test@test.com";
      final String password = "password";

      when(mockLoginRepository.login(email: email, password: password))
          .thenAnswer((_) async => false);

      bool result = await loginProvider.login(email: email, password: password);

      verify(mockLoginRepository.login(email: email, password: password));

      expect(result, false);
    });
  });

  group("User Status :", () {
    test("Check user already logged in", () async {
      when(mockLoginRepository.checkAlredyLogin())
          .thenAnswer((realInvocation) async => true);

      bool isUserLoggedIn = await loginProvider.checkAlredyLogin();

      verify(mockLoginRepository.checkAlredyLogin());

      expect(isUserLoggedIn, true);
    });
  });
}
