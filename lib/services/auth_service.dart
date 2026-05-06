class AuthService {
  Future<String?> login(String email, String senha) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == "oii@gmail.com" && senha == "123456") {
      return "sucesso_token_123";
    }

    return null;
  }
}