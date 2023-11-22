import 'package:flutter/material.dart';
import 'package:imc_kalil/controllers/medicao_controller.dart';
import 'package:imc_kalil/models/medicao.dart';

class ListagemTela extends StatefulWidget {
  const ListagemTela({super.key});

  @override
  State<ListagemTela> createState() => _ListagemTelaState();
}

class _ListagemTelaState extends State<ListagemTela> {
  var medicaoController = MedicaoController();
  var pesoController = TextEditingController(text: '');
  var alturaController = TextEditingController(text: '');

  void novaMedicao(BuildContext context) {
    setState(() {
      pesoController.text = '';
      alturaController.text = '';
    });
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: const Text("Adicionar Medição"),
            content: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Entre com seu peso em Kg"),
                    TextField(
                      controller: pesoController,
                      keyboardType: TextInputType.number,
                    ),
                    const Divider(
                      height: 20,
                    ),
                    const Text("Entre com sua altura em cm"),
                    TextField(
                      controller: alturaController,
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextButton(
                          child: const Text("Salvar"),
                          onPressed: () {
                            adicionarMedicao();
                            Navigator.pop(context);
                          },
                        )),
                        Expanded(
                            child: TextButton(
                          child: const Text("Cancelar"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ))
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  void adicionarMedicao() {
    var medicao = Medicao();
    medicao.altura = double.parse(alturaController.text);
    medicao.peso = double.parse(pesoController.text);
    medicaoController.adicionar(medicao);
    setState(() {
      medicaoController.listar();
    });
  }

  ListView widgetListagem() {
    return ListView(
      children: medicaoController.listar().map((medicao) {
        Text? resultado;
        if (medicao.imc < 16.0) {
          resultado = const Text(
            "Magreza grave",
            style: TextStyle(color: Colors.deepPurple),
          );
        } else if (medicao.imc < 17.0) {
          resultado = const Text(
            "Magreza moderada",
            style: TextStyle(color: Colors.purple),
          );
        } else if (medicao.imc < 18.5) {
          resultado = const Text(
            "Magreza Leve",
            style: TextStyle(color: Colors.blueAccent),
          );
        } else if (medicao.imc < 25.0) {
          resultado = const Text(
            "Saudável",
            style: TextStyle(color: Colors.green),
          );
        } else if (medicao.imc < 35.0) {
          resultado = Text(
            "Obesidade grau 1",
            style: TextStyle(color: Colors.red[200]),
          );
        } else if (medicao.imc < 40.0) {
          resultado = Text(
            "Obesidade grau 2 (SEVERA)",
            style: TextStyle(color: Colors.red[500]),
          );
        } else {
          resultado = Text(
            "Obesidade grau 3 (MÓRBIDA)",
            style: TextStyle(color: Colors.red[900]),
          );
        }
        return ListTile(
          title: Text(
              "IMC: ${medicao.imc.toStringAsFixed(2)} (Peso: ${medicao.peso} / Altura ${medicao.altura})"),
          subtitle: resultado,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medidor de IMC"),
      ),
      body: widgetListagem(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          novaMedicao(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
