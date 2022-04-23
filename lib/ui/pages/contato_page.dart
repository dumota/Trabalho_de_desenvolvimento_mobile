import 'package:flutter/material.dart';

import '../components/components.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({Key? key}) : super(key: key);

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _assuntoController = TextEditingController();
  final _mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contato'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.help_outline)),
        ],
      ),
      body: ListView(
        children: [
          CampoTexto(texto: "digite seu nome", controlador: _nomeController,),
          CampoTexto(
            controlador: _emailController,
            texto: "digite seu Email",
            teclado: TextInputType.emailAddress,
            prefixo: "@",
          ),
          CampoTexto(
              controlador: _assuntoController, texto: "assunto do email"),
          CampoTexto(
              controlador: _mensagemController, texto: "Mensagem do e-mail"),
          BotaoQuadrado(texto: "enviar", clique: enviarEmail)
        ],
      ),
    );
  }

  void enviarEmail() async {
    const usuario = "seuEmail.com";
    const senha = "sua_senha";

    final smtpServer = gmail(usuario, senha);

    final mensagem = Message()
      ..from = const Address(usuario, "Contato")
      ..recipients.add(usuario)
      ..subject = _assuntoController.text
      ..text = """Nome: ${_nomeController.text},
          E-mail: ${_emailController.text},
          Mensagem: ${_mensagemController.text}""";

    await send(mensagem, smtpServer);

    setState(() {
      _nomeController.clear();
      _emailController.clear();
      _assuntoController.clear();
      _mensagemController.clear();
    });
  }
}
