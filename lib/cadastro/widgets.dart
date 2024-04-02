
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


import '../widgets_gerais.dart';
import 'logica.dart';

class WidgetsCadastro {
  WidgetsGerais widgetsGerais = WidgetsGerais();
  LogicaCadastro logicaCadastro = LogicaCadastro();

  Widget errosLoginCad(
      {required String logOuCad,
      required BuildContext context,
      required Color cor,
      required int numAlert}) {
    if (logOuCad == 'login') {
      return CupertinoAlertDialog(
        title: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: const Text(
              'E-mail ou senha inválidos!',
              style: TextStyle(fontFamily: 'SourceSansPro'),
            )),
        content: const Text(
            'O seu e-mail ou senhas estão incorretos, tente novamente!',
            style: TextStyle(fontFamily: 'SourceSansPro')),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Tentar novamente',
                style: TextStyle(color: cor),
              ))
        ],
      );
    } else {
      if (numAlert == 1) {
        return CupertinoAlertDialog(
          title: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: const Text(
                'Cadastro efetuado com sucesso!',
                style: TextStyle(fontFamily: 'SourceSansPro'),
              )),
          content: const Text(
              'O seu cadastro foi realizado com sucesso faça login agora mesmo!',
              style: TextStyle(fontFamily: 'SourceSansPro')),
          actions: [
            TextButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Login()),
                  // );
                },
                child: Text(
                  'Fazer login',
                  style: TextStyle(color: cor),
                ))
          ],
        );
      }

      else {
        return CupertinoAlertDialog(
          title: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: const Text(
                'Erro ao efetuar o cadastro!',
                style: TextStyle(fontFamily: 'SourceSansPro'),
              )),
          content: const Text(
              'Verifique se  todos os campos foram preenchidos corretamente e tente novamente.',
              style: TextStyle(fontFamily: 'SourceSansPro')),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tentar novamente',
                  style: TextStyle(color: cor),
                ))
          ],
        );
      }
    }
  }

  void mostrarDialogoCadastro(BuildContext context, int tipo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errosLoginCad(
            logOuCad: 'cadastro',
            context: context,
            cor: widgetsGerais.customColor(),
            numAlert: tipo);
      },
    );
  }

  Widget sessaoInput(BuildContext context, {String tipo = 'nome'}) {
    Map<String, Widget> textFields = {
      'nome': Form(
        key: logicaCadastro.formKeyNome,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.telefoneFocus);
          },
          validator: (value) {
            String pattern =
                r'^[a-zA-ZÁÉÍÓÚáéíóúÂÊÔâêôÃÕãõÇç\s-]{2,}\s[a-zA-ZÁÉÍÓÚáéíóúÂÊÔâêôÃÕãõÇç\s-]{2,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              logicaCadastro.erros.add(1);
              return 'Insira o seu nome completo';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 1);
              return null;
            }
          },
          controller: logicaCadastro.nomeControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.account,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'Nome completo',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                    BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'telefone': Form(
        key: logicaCadastro.formKeyTelefone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.telefoneFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.nascimentoFocus);
          },
          validator: (value) {
            if (value!.length <= 13) {
              logicaCadastro.erros.add(2);
              return 'Insira um telefone válido';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 2);
              return null;
            }
          },
          controller: logicaCadastro.telefoneControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.phone,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'Telefone',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'email': Form(
        key: logicaCadastro.formKeyEmail,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.emailFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.passwordFocus);
          },
          validator: (value) {
            String pattern =
                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // Expressão regular para validar e-mail
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              logicaCadastro.erros.add(3);
              return 'Insira um e-mail válido';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 3);
              return null;
            }
          },
          controller: logicaCadastro.emailControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.email,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'E-mail',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'nascimento': Form(
        key: logicaCadastro.formKeyNascimento,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.nascimentoFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.enderecoFocus);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              logicaCadastro.erros.add(5);
              return 'Insira uma data de nascimento';
            }

            // Verifica o formato da data (dd/mm/aaaa)
            String pattern = r'^\d{2}/\d{2}/\d{4}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value)) {
              logicaCadastro.erros.add(5);
              return 'Formato inválido. Use dd/mm/aaaa';
            }

            // Converte a string em uma data
            List<String> parts = value.split('/');
            int dia = int.parse(parts[0]);
            int mes = int.parse(parts[1]);
            int ano = int.parse(parts[2]);
            DateTime dataNascimento;
            try {
              dataNascimento = DateTime(ano, mes, dia);
            } catch (e) {
              logicaCadastro.erros.add(5);
              return 'Data inválida';
            }

            // Verifica se a data é futura
            if (dataNascimento.isAfter(DateTime.now())) {
              logicaCadastro.erros.add(5);
              return 'Data de nascimento não pode ser no futuro';
            }

            DateTime hoje = DateTime.now();
            DateTime dezoitoAnosAtras = DateTime(hoje.year - 18, hoje.month, hoje.day);

            if (dataNascimento.isAfter(dezoitoAnosAtras)) {
              logicaCadastro.erros.add(5);
              return 'Você deve ter pelo menos 18 anos';
            }

            // Aqui você pode adicionar outras validações, como idade mínima, se necessário

            logicaCadastro.erros.removeWhere((element) => element == 5);
            return null;
          },
          controller: logicaCadastro.nascimentoControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.calendar,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'Data de nascimento',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'endereco': Form(
        key: logicaCadastro.formKeyEndereco,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.enderecoFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco
            FocusScope.of(context).requestFocus(logicaCadastro.cpfFocus);
          },
          validator: (value) {
            String pattern =
                r'^[0-9a-zA-ZÁÉÍÓÚáéíóúÂÊÔâêôÃÕãõÇç\s,.#-]{5,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              logicaCadastro.erros.add(6);
              return 'Insira um endereço correto';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 6);
              return null;
            }
          },
          controller: logicaCadastro.enderecoControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.city,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'Endereço de residência',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'cpf': Form(
        key: logicaCadastro.formKeyCpf,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.cpfFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.rgFocus);
          },
          validator: (value) {
            if (value!.length < 14) {
              logicaCadastro.erros.add(7);
              return 'Insira um CPF válido';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 7);
              return null;
            }
          },
          controller: logicaCadastro.cpfControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.account_key,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'CPF',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'rg': Form(
        key: logicaCadastro.formKeyRg,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.rgFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.cnhFocus);
          },
          validator: (value) {
            if (value!.length < 12) {
              logicaCadastro.erros.add(8);
              return 'Insira um RG válido';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 8);
              return null;
            }
          },
          controller: logicaCadastro.rgControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.account_key,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'RG',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'cnh': Form(
        key: logicaCadastro.formKeyCnh,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.cnhFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.renavamFocus);
          },
          validator: (value) {
            if (value!.length < 11) {
              logicaCadastro.erros.add(9);
              return 'Insira uma CNH válida';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 9);
              return null;
            }
          },
          controller: logicaCadastro.cnhControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.car,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'CNH',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'renavam': Form(
        key: logicaCadastro.formKeyRenavam,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.renavamFocus,
          onFieldSubmitted: (term) {
            // Quando o usuário pressiona "Next" no teclado, muda o foco para o campo de senha
            FocusScope.of(context).requestFocus(logicaCadastro.placaFocus);
          },
          validator: (value) {
            if (value!.length < 11) {
              logicaCadastro.erros.add(10);
              return 'Insira um RENAVAM válido';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 10);
              return null;
            }
          },
          controller: logicaCadastro.renavamControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.card_search_outline,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'RENAVAM',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'placa': Form(
        key: logicaCadastro.formKeyPlaca,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.placaFocus,
          validator: (value) {
            if (value!.length < 7) {
              logicaCadastro.erros.add(11);
              return 'Insira uma PLACA válida';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 11);
              return null;
            }
          },
          controller: logicaCadastro.placaControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.numeric,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'Placa do veículo',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'modelo': Form(
        key: logicaCadastro.formKeyModelo,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.modeloFocus,
          validator: (value) {
            if (value!.length < 2) {
              logicaCadastro.erros.add(12);
              return 'Modelo veiculo: Ex Gol - Siena - Polo';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 12);
              return null;
            }
          },
          controller: logicaCadastro.modeloControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.car,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'Modelo veiculo: Ex Gol / Polo',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
      'ano': Form(
        key: logicaCadastro.formKeyAno,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          focusNode: logicaCadastro.anoFocus,
          validator: (value) {
            if (value!.length < 2) {
              logicaCadastro.erros.add(15);
              return 'Ano do veiculo: Min: 2010';
            } else {
              logicaCadastro.erros.removeWhere((element) => element == 15);
              return null;
            }
          },
          controller: logicaCadastro.anoControle,
          cursorColor: const Color(0xFF727272),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Container(
                  margin: const EdgeInsets.all(15),
                  child: const Icon(
                    CommunityMaterialIcons.car,
                    size: 35,
                    color: Color(0xFF727272),
                  )),
              labelText: 'Ano do veiculo: Min: 2010',
              filled: true,
              fillColor: const Color(0xFFdcdcdc),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Remove a borda externa
                borderRadius:
                BorderRadius.circular(15), // Arredonda os cantos
              ),
              labelStyle: const TextStyle(
                  color: Color(0xFF727272),
                  fontFamily: 'SourceSansPro',
                  fontSize: 18)),
        ),
      ),
    };

    return Container(margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),child: textFields[tipo]);
  }

  Widget categoria(String categoria){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Row(
        children: [
          Text(categoria, style: GoogleFonts.mulish(
              fontSize: 23, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Future<void> mostrarTermos(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            children: [
              Expanded(
                child: Container(width: double.infinity,child:
                Container(
                    child: SfPdfViewer.asset(
                        'https://issacwilliandev.github.io/developer/termos.pdf')),
                  ),
              ),
              SizedBox(height: 10,),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Entendi os termos de uso!', style: TextStyle(color: widgetsGerais.customColor()),)),
              SizedBox(height: 10,)
            ],
          ),
        );
      },
    );
  }

  Future<void> mostrarPolitica(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            children: [
              Expanded(
                child: Container(width: double.infinity,child:
                Container(
                    child: SfPdfViewer.network(
                        'https://issacwilliandev.github.io/developer/politica.pdf')),
                ),
              ),
              SizedBox(height: 10,),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Entendi a politica de privacidade!', style: TextStyle(color: widgetsGerais.customColor()),)),
              SizedBox(height: 10,)
            ],
          ),
        );
      },
    );
  }

}
