import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

class LogicaCadastro{
  Uint8List? imagemPerfilBytes;
  static final LogicaCadastro _singleton =
  LogicaCadastro._internal();

  LogicaCadastro._internal();

  // Fábrica para retornar a única instância
  factory LogicaCadastro() {
    return _singleton;
  }

  bool showHidePass = true;


  String imagemPerfil = 'assets/imagens/imagem_perfil/perfil.png';
  final picker = ImagePicker();
  Color corCamera = Colors.black;

  // NOME COMPLETO
  final formKeyNome = GlobalKey<FormState>();
  final nomeControle = TextEditingController();

  // ENDEREÇO
  final formKeyEndereco = GlobalKey<FormState>();
  final enderecoControle = TextEditingController();
  final enderecoFocus = FocusNode();

  // TELEFONE
  final telefoneFocus = FocusNode();
  final formKeyTelefone = GlobalKey<FormState>();
  final telefoneControle = MaskedTextController(mask: '(00) 00000-0000');

  // CPF
  final cpfFocus = FocusNode();
  final formKeyCpf = GlobalKey<FormState>();
  final cpfControle = MaskedTextController(mask: '000.000.000-00');

  // RG
  final rgFocus = FocusNode();
  final formKeyRg = GlobalKey<FormState>();
  final rgControle = MaskedTextController(mask: '00.000.000-0');

  // CNH
  final cnhFocus = FocusNode();
  final formKeyCnh = GlobalKey<FormState>();
  final cnhControle = MaskedTextController(mask: '00000000000');

  // RENAVAM
  final renavamFocus = FocusNode();
  final formKeyRenavam = GlobalKey<FormState>();
  final renavamControle = MaskedTextController(mask: '00000000000');

  // ENDEREÇO
  final formKeyPlaca = GlobalKey<FormState>();
  final placaControle = TextEditingController();
  final placaFocus = FocusNode();

  // MODELO
  final formKeyModelo = GlobalKey<FormState>();
  final modeloControle = TextEditingController();
  final modeloFocus = FocusNode();


  // ANO
  final formKeyAno = GlobalKey<FormState>();
  final anoControle = TextEditingController();
  final anoFocus = FocusNode();


  // NASCIMENTO
  final nascimentoFocus = FocusNode();
  final formKeyNascimento = GlobalKey<FormState>();
  final nascimentoControle = MaskedTextController(mask: '00/00/0000');

  // E-MAIL
  final emailFocus = FocusNode();
  final formKeyEmail = GlobalKey<FormState>();
  final emailControle = TextEditingController();

  // SENHA
  final passwordFocus = FocusNode();
  final formKeySenha = GlobalKey<FormState>();
  final senhaControle = TextEditingController();


  // INFORMAÇÕES VEICULO
  late String corVeiculo;
  late String marcaVeiculo;
  String atuacao = 'Pop';
  bool entregas = true;
  bool termosDeUso = false;
  bool politica = false;



  static const List<String> cores = <String>['Azul', 'Branco', 'Chumbo', 'Laranja', 'Preto', 'Verde', 'Vermelho'];

  static const List<String> modelos = <String>['Chevrolet', 'Volkswagen', 'Fiat', 'Ford', 'Toyota', 'Hyundai', 'Renault', 'Honda', 'Peugeot', 'Nissan'];


  IconData iconeShowHide = Icons.visibility;


  // BOTÃO FAZER CADASTRO
  final List<int> erros = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> registerUser(String email, String password) async {
    try {
      final UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Usuário registrado: ${user.user?.email}");
      return true;
    } catch (e) {
      print("Erro ao registrar: $e");
      return false;
    }
  }

  Future<String> uploadImgPerfil({required Uint8List bytes, required String chatId}) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('perfil/$chatId/$timestamp');

      // Upload da imagem usando putData
      await ref.putData(bytes);

      // Obtenção da URL da imagem
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Erro no upload da imagem: $e');
      return "";
    }
  }


}