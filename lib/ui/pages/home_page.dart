import 'package:flutter/material.dart';
import 'package:trabalho_marcos/ui/components/components.dart';
import 'package:trabalho_marcos/ui/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculo Imc"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Contato",
                style: TextStyle(fontSize: 22),
              ),
              textColor: Colors.black,
              trailing: Icon(Icons.book),
              onTap: abrirContato,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: ListView(
          children: [
            CampoTexto(
                controlador: _alturaController,
                texto: "Altura",
                teclado: TextInputType.number),
            CampoTexto(
                controlador: _pesoController,
                texto: "Peso",
                teclado: TextInputType.number),
            BotaoQuadrado(texto: "calcular", clique: _calcular)
          ],
        ),
      ),
    );
  }

  void abrirContato() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ContatoPage()));
  }

  void _calcular() {
    String mensagem;
    double altura =
        double.tryParse(_alturaController.text.replaceAll(',', '.')) ?? 0;
    double peso =
        double.tryParse(_pesoController.text.replaceAll(',', '.')) ?? 0;
    double imc = peso / (altura * altura);

    if (altura <= 0) {
      _showMessage('Digite uma altura Valida');
      return;
    }
    if (peso <= 0) {
      _showMessage('Digite um peso valido');
      return;
    }

    if (imc < 18.5) {
      mensagem = ("abaixo do peso");
    } else if (imc >= 18.5 && imc < 25) {
      mensagem =("peso normal");
    } else if (imc >= 25 && imc < 30) {
      mensagem =("Sobrepeso");
    } else if (imc >= 30 && imc < 35) {
      mensagem =("obesidade grau 1");
    } else if (imc >= 35 && imc < 40) {
      mensagem =("Obesidade grau 2");
    } else {
      mensagem =("Obesidade grau 3");
    }

    setState(() {
      _resetFields();
      _showMessage('${mensagem}');
    });
  }

  void _resetFields() {
    setState(() {
      _alturaController.text = "";
      _pesoController.text = "";
    });
  }

   void _showMessage(String texto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Calculador de Imc', style: TextStyle(fontSize: 22),),
          content: Text(texto, style: const TextStyle(fontSize: 20),)
        );
      }  
    );
  }
}
