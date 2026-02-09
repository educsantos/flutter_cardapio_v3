import 'dart:async';

// Contrato: A UI depende desta abstração, não do Firebase diretamente
abstract class IAuthService {
  Stream<String?> get onAuthStateChanged;
  Future<bool> login(String email, String password);
  Future<void> logout();
}

class MockAuthService implements IAuthService {
  final _controller = StreamController<String?>();

  @override
  Stream<String?> get onAuthStateChanged => _controller.stream;

  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == "admin@email.com" && password == "segredo") {
      _controller.add("token_logado");
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    _controller.add(null);
  }
}