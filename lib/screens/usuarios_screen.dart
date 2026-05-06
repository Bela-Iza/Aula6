import 'package:flutter/material.dart';
import '/models/usuario.dart';
import '/services/api_service.dart';
import '/theme.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final api = ApiService();

  List<Usuario> usuarios = [];
  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    buscar();
  }

  Future<void> buscar() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      usuarios = await api.buscarUsuarios();
    } catch (e) {
      erro = "Erro ao carregar usuários";
    }

    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: buscar,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (carregando) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Carregando usuários...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      );
    }

    if (erro != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 60, color: Colors.red),
            const SizedBox(height: 10),
            Text(erro!),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: buscar,
              child: const Text("Tentar novamente"),
            )
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: usuarios.length,
      itemBuilder: (context, index) {
        final u = usuarios[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.secondary,
              child: Text(
                u.nome.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              u.nome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${u.email}\n${u.cidade}"),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}