import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro do responsável',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202F58)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202F58)),
          ),
          labelStyle: TextStyle(
            color: Color(0xFF202F58),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202F58)),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202F58)),
          ),
        ),
      ),
      home: CadastroForm(),
    );
  }
}

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  String? _para = '';
  String? _unidadeRecebedora = '';
  String? _endereco = '';
  String? _cidade = 'Manaus, Amazonas';
  String? _cep = '';
  String? _telefone = '';
  String? _responsavel = '';
  String? _assinatura = '';
  String? _matricula = '';

  SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5, // Espessura do traço da caneta
    penColor: Colors.black, // Cor da caneta
    exportBackgroundColor: Colors.transparent, // Cor de fundo ao exportar a imagem
  );

  void clearSignature() {
    _signatureController.clear();
  }

  Future<Uint8List> getSignatureImage() async {
    if (_signatureController.isNotEmpty) {
      final signature = await _signatureController.toPngBytes();
      return signature!;
    }
    return Uint8List(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Color(0xFF43AD59),
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Image.asset(
                    'assets/images/Logo_Governo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Image.asset(
                    'assets/images/Logo_Sead.png',
                    height: 180,
                    width: 120,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cadastro do responsável',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Para:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome do destinatário',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o nome do destinatário';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _para = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Unidade Recebedora:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome da unidade recebedora',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o nome da unidade recebedora';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _unidadeRecebedora = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Endereço:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Endereço da unidade recebedora',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o endereço da unidade recebedora';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _endereco = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Cidade:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Cidade da unidade recebidora',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe a cidade';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cidade = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'CEP:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'CEP da unidade recebedora',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o CEP da unidade recebedora';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cep = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Telefone:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Telefone para contato',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o telefone para contato';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _telefone = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Matrícula:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Número de matrícula',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o número de matrícula';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _matricula = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Responsável:',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome do responsável',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o nome do responsável';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _responsavel = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Assinatura:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Signature(
                    controller: _signatureController,
                    height: 150,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          clearSignature();
                        });
                      },
                      child: Text('Limpar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmationScreen(
                                para: _para!,
                                unidadeRecebedora: _unidadeRecebedora!,
                                endereco: _endereco!,
                                cidade: _cidade!,
                                cep: _cep!,
                                telefone: _telefone!,
                                responsavel: _responsavel!,
                                assinatura: _assinatura!,
                                matricula: _matricula!,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Enviar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  final String para;
  final String unidadeRecebedora;
  final String endereco;
  final String cidade;
  final String cep;
  final String telefone;
  final String responsavel;
  final String assinatura;
  final String matricula;

  ConfirmationScreen({
    required this.para,
    required this.unidadeRecebedora,
    required this.endereco,
    required this.cidade,
    required this.cep,
    required this.telefone,
    required this.responsavel,
    required this.assinatura,
    required this.matricula,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmação'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirme os dados:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Para: $para'),
            Text('Unidade Recebedora: $unidadeRecebedora'),
            Text('Endereço: $endereco'),
            Text('Cidade: $cidade'),
            Text('CEP: $cep'),
            Text('Telefone: $telefone'),
            Text('Responsável: $responsavel'),
            Text('Matrícula: $matricula'),
            SizedBox(height: 16),
            Text('Assinatura:'),
            SizedBox(height: 8),
            Image.memory(
              base64Decode(assinatura),
              height: 90,
              width: 90,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}