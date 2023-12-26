import 'package:flutter/material.dart';
import 'package:imc_kalil/telas/listagem.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  //Certifica que todos os bindings estarão carregadas no inicio
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ListagemTela());
  }
}
