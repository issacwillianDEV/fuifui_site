import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'dart:io';
import 'dart:math';

import '../logica_geral.dart';
import 'logica.dart';

class DatabaseCadastro {
  CollectionReference users =
      FirebaseFirestore.instance.collection('motoristas');
  LogicaCadastro logicaCadastro = LogicaCadastro();

  Future<bool> setCadastrarUsuario(BuildContext context) async {
    bool retornobd = await cadastrarUsuario(
        nome: logicaCadastro.nomeControle.text,
        telefone: logicaCadastro.telefoneControle.text,
        nascimento: logicaCadastro.nascimentoControle.text,
        endereco: logicaCadastro.enderecoControle.text,
        cpf: logicaCadastro.cpfControle.text,
        rg: logicaCadastro.rgControle.text,
        cnh: logicaCadastro.cnhControle.text,
        renavam: logicaCadastro.renavamControle.text,
        placa: logicaCadastro.placaControle.text,
        corVeiculo: logicaCadastro.corVeiculo,
        marcaVeiculo: logicaCadastro.marcaVeiculo,
        ano: logicaCadastro.anoControle.text,
        modeloVeiculo: logicaCadastro.modeloControle.text,
        categoriaAtuacao: logicaCadastro.atuacao,
        entregas: logicaCadastro.entregas,
        email: logicaCadastro.emailControle.text,
        perfil: logicaCadastro.imagemPerfil,
        context: context);

    return retornobd;
  }

  Future<bool> cadastrarUsuario(
      {required String nome,
      required String telefone,
      required String nascimento,
      required String endereco,
      required String cpf,
      required String rg,
      required String cnh,
      required String renavam,
      required String placa,
      required String corVeiculo,
      required String marcaVeiculo,
      required String modeloVeiculo,
        required String ano,
      required String categoriaAtuacao,
      required bool entregas,
      required String email,
      required String perfil,
      required BuildContext context}) async {
    try {

      String retornoImg = await logicaCadastro.uploadImgPerfil(
          bytes: logicaCadastro.imagemPerfilBytes!, chatId: email);


      int randomUsuario = 9999 + Random().nextInt(99999 - 9999);

      Timestamp agora = Timestamp.now();


      users.add({
        'avaliacoes': [5],
        'infos': {
          'aprovacao': 'aprovado',
          'ativo': false,
          'atuacao': categoriaAtuacao.toLowerCase(),
          'entrega': entregas,
          'idMotorista': randomUsuario,
          'solicitacoes': 0,
          'tokenfcm': 'cadastro no site',
          'ultimo_login': agora,
          'banido': false,
        },
        'localizacao': {
          'geohash': 'geofire.hash',
          'geopoint': 'geofire.geoPoint'
        },
        'pagamento':{
          'cobranca_dias': 30,
          'em_teste': true,
          'periodo_teste': 20,
          'primeiro_login': false,
          'ultimo_pagamento': agora,
          'primeiraCorrida': false
        },
        'pessoal': {
          'email': email,
          'img_perfil': retornoImg,
          'nome': nome,
          'telefone': telefone,
          'data_nascimento': nascimento,
          'endereco': endereco,
          'cpf': cpf,
          'rg': rg,
          'cnh': cnh
        },
        'veiculo':{
          'veiculo_cor': corVeiculo.toLowerCase(),
          'veiculo_marca': marcaVeiculo,
          'veiculo_modelo': '$modeloVeiculo $ano',
          'veiculo_placa': placa,
          'renavam': renavam
        },
        'selo':{
          'ativo': false,
          'tipo': 'Motorista Vip'
        }
        // Outros campos podem ser adicionados aqui
      });
      return true;
    } catch (e) {
      print('error: $e');
      return false;
    }
  }
}
