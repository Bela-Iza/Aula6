class AuthService {
  Future<String?> login(String email, String senha) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == "aluno@etec.sp.gov.br" && senha == "123456") {
      return "sucesso_token_123";
    }

    return null;
  }
}