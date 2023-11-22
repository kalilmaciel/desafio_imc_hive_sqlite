import 'package:imc_kalil/models/medicao.dart';

class MedicaoController {
  List<Medicao> _medicoes = <Medicao>[];

  void adicionar(Medicao medicao) {
    _medicoes.add(medicao);
  }

  List<Medicao> listar() {
    return _medicoes;
  }

  void remover(Medicao medicao) {
    _medicoes
        .remove(_medicoes.where((element) => element.id == medicao.id).first);
  }
}
