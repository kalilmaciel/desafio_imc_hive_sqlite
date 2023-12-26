import 'package:hive/hive.dart';
import 'package:imc_kalil/models/medicao.dart';
import 'package:imc_kalil/repositories/database_sqlite.dart';

class MedicaoRepository {
  Future<int?> adicionar(Medicao medicao) async {
    await DatabaseSqlite.initDatabase();
    if (DatabaseSqlite.db != null) {
      await setAltura(medicao.altura);
      var sql = "INSERT INTO medicoes (peso, altura) VALUES (?, ?)";
      var dados = [medicao.peso, medicao.altura];
      return await DatabaseSqlite.db?.rawInsert(sql, dados);
    }
    return null;
  }

  Future<List<Medicao>> listar() async {
    await DatabaseSqlite.initDatabase();
    if (DatabaseSqlite.db != null) {
      var sql = "SELECT id, peso, altura FROM medicoes ORDER BY id desc";
      var lista = await DatabaseSqlite.db?.rawQuery(sql);
      List<Medicao> retorno = [];
      if (lista != null) {
        for (var item in lista) {
          retorno.add(Medicao(
              int.parse(item['id'].toString()),
              double.parse(item['peso'].toString()),
              double.parse(item['altura'].toString())));
        }
        return retorno;
      }
    }
    return [];
  }

  Future<int?> remover(Medicao medicao) async {
    await DatabaseSqlite.initDatabase();
    if (DatabaseSqlite.db != null) {
      var sql = "DELETE FROM medicoes WHERE id = ?";
      var dados = [medicao.id];
      return await DatabaseSqlite.db?.rawDelete(sql, dados);
    }
    return null;
  }

  setAltura(double value) async {
    Box box;
    if (Hive.isBoxOpen('altura')) {
      box = Hive.box('altura');
    } else {
      box = await Hive.openBox('altura');
    }
    box.put('altura', value);
  }

  Future<double> getAltura() async {
    Box box;
    if (Hive.isBoxOpen('altura')) {
      box = Hive.box('altura');
    } else {
      box = await Hive.openBox('altura');
    }
    return (await box.get('altura')) ?? 0;
  }

  setNome(int value) async {
    var box = Hive.box('box');
    box.put('nome', value);
  }

  Future<int> getNome() async {
    var box = Hive.box('box');
    return (await box.get('nome')) ?? 'Usuário';
  }
}
