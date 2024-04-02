import 'dart:io';
import 'dart:math';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilidade_urbana_site/cadastro/widgets.dart';
import 'package:mobilidade_urbana_site/logica_geral.dart';
import 'package:mobilidade_urbana_site/sucesso/sucesso.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../widgets_gerais.dart';
import 'database.dart';
import 'logica.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  IconData _iconeShowHide = Icons.visibility;

  //  Logica
  WidgetsCadastro widgetsCustomizados = WidgetsCadastro();
  LogicaCadastro logicaCadastrar = LogicaCadastro();
  DatabaseCadastro database = DatabaseCadastro();
  LogicaGeral logicaGeral = LogicaGeral();
  // CAMERA

  WidgetsGerais widgetsCustomizado = WidgetsGerais();

  bool retornobd = false;

  @override
  void dispose() {
    logicaCadastrar.emailControle.dispose();
    logicaCadastrar.senhaControle.dispose();

    logicaCadastrar.nomeControle.dispose();
    logicaCadastrar.enderecoControle.dispose();
    logicaCadastrar.telefoneControle.dispose();
    logicaCadastrar.cpfControle.dispose();
    logicaCadastrar.rgControle.dispose();
    logicaCadastrar.renavamControle.dispose();
    logicaCadastrar.placaControle.dispose();
    logicaCadastrar.modeloControle.dispose();
    logicaCadastrar.anoControle.dispose();
    logicaCadastrar.nascimentoControle.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFffffff), // Cor da barra de navegação
      systemNavigationBarIconBrightness: Brightness
          .dark, // Ícones da barra de navegação (isso os tornará escuros se a barra for clara)
    ));

    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                child: Image.asset(
                  'assets/imagens/logo/logo-ff.png',
                  height: 130,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                width: double.infinity,
                child: Center(
                    child: Text(
                  'Fazer cadastro',
                  style: GoogleFonts.mulish(
                      fontSize: 32, fontWeight: FontWeight.w700),
                )),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: double.infinity,
                child: Center(
                    child: Text(
                  textAlign: TextAlign.center,
                  'Abra sua conta agora, sem complicações, e solicite um motorista de maneira inovadora!',
                  style: GoogleFonts.mulish(
                      fontSize: 17, fontWeight: FontWeight.w300),
                )),
              ),

              //  INFORMAÇÕES PESSOAIS
              widgetsCustomizados.categoria('Informações pessoais'),

              widgetsCustomizados.sessaoInput(context, tipo: 'nome'),
              widgetsCustomizados.sessaoInput(context, tipo: 'telefone'),
              widgetsCustomizados.sessaoInput(context, tipo: 'nascimento'),
              widgetsCustomizados.sessaoInput(context, tipo: 'endereco'),

              // DOCUMENTAÇÃO
              widgetsCustomizados.categoria('Documentação pessoal'),

              widgetsCustomizados.sessaoInput(context, tipo: 'cpf'),
              widgetsCustomizados.sessaoInput(context, tipo: 'rg'),
              widgetsCustomizados.sessaoInput(context, tipo: 'cnh'),

              // Documentação veiculo

              widgetsCustomizados.categoria('Documentação do veículo'),

              widgetsCustomizados.sessaoInput(context, tipo: 'renavam'),
              widgetsCustomizados.sessaoInput(context, tipo: 'placa'),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text('Selecionar cor do veículo'),
                      ),
                    ],
                  ),
                  DropdownMenu(
                    width: MediaQuery.of(context).size.width * 0.85,
                    hintText: 'Selecione a cor do veículo',
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        logicaCadastrar.erros
                            .removeWhere((element) => element == 13);
                        logicaCadastrar.corVeiculo = value!;
                      });
                    },
                    dropdownMenuEntries: LogicaCadastro.cores
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text('Selecionar a marca do veículo'),
                      ),
                    ],
                  ),
                  DropdownMenu(
                    width: MediaQuery.of(context).size.width * 0.85,
                    hintText: 'Selecione a marca do veículo',
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        logicaCadastrar.erros
                            .removeWhere((element) => element == 14);
                        logicaCadastrar.marcaVeiculo = value!;
                      });
                    },
                    dropdownMenuEntries: LogicaCadastro.modelos
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ],
              ),

              widgetsCustomizados.sessaoInput(context, tipo: 'modelo'),
              widgetsCustomizados.sessaoInput(context, tipo: 'ano'),

              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                            'Categoria do veículo (analisaremos a categoria)'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Pop',
                                    style: GoogleFonts.mulish(fontSize: 18),
                                  ),
                                  Radio<String>(
                                      activeColor:
                                          widgetsCustomizado.customColor(),
                                      value: 'Pop',
                                      groupValue: logicaCadastrar.atuacao,
                                      onChanged: (String? value) {
                                        setState(() {
                                          logicaCadastrar.atuacao = value!;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Comfort',
                                    style: GoogleFonts.mulish(fontSize: 18),
                                  ),
                                  Radio<String>(
                                      activeColor:
                                          widgetsCustomizado.customColor(),
                                      value: 'Comfort',
                                      groupValue: logicaCadastrar.atuacao,
                                      onChanged: (String? value) {
                                        setState(() {
                                          logicaCadastrar.atuacao = value!;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      children: [
                        Text('Você deseja também realizar entregas no app?'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: widgetsCustomizado.customColor(),
                          value: logicaCadastrar.entregas,
                          onChanged: (bool? value) {
                            setState(() {
                              logicaCadastrar.entregas = value!;
                            });
                          }),
                      Text('Sim, vou realizar entregas',
                          style: GoogleFonts.mulish(fontSize: 18)),
                    ],
                  ),
                ],
              ),

              widgetsCustomizados.categoria('Ultima etapa'),
              widgetsCustomizados.sessaoInput(context, tipo: 'email'),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Form(
                  key: logicaCadastrar.formKeySenha,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: logicaCadastrar.senhaControle,
                    obscureText: logicaCadastrar.showHidePass,
                    focusNode: logicaCadastrar.passwordFocus,
                    validator: (value) {
                      if (value!.length >= 2 && value.length <= 6) {
                        logicaCadastrar.erros.add(4);
                        return 'A senha deve conter pelo menos 6 caracteres';
                      } else {
                        logicaCadastrar.erros
                            .removeWhere((element) => element == 4);
                        return null;
                      }
                    },
                    cursorColor: const Color(0xFF727272),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _iconeShowHide,
                            color: const Color(0xFF727272),
                          ),
                          onPressed: () {
                            setState(() {
                              logicaCadastrar.showHidePass =
                                  !logicaCadastrar.showHidePass;
                              if (logicaCadastrar.showHidePass) {
                                _iconeShowHide = Icons.visibility;
                              } else {
                                _iconeShowHide = Icons.visibility_off;
                              }
                            });
                          },
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Container(
                            margin: const EdgeInsets.all(15),
                            child: const Icon(
                              CommunityMaterialIcons.lock,
                              size: 35,
                              color: Color(0xFF727272),
                            )),
                        labelText: 'Senha',
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
              ), // SENHA

              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: const Text(
                  'Foto de perfil\nClique na câmera para selecionar uma foto.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontFamily: 'SourceSansPro'),
                ),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: ClipOval(
                    child: Stack(children: [
                  if (logicaCadastrar.imagemPerfilBytes != null)
                    Positioned.fill(
                      child: Image.memory(logicaCadastrar.imagemPerfilBytes!,
                          fit: BoxFit.cover),
                    ),
                  if (logicaCadastrar.imagemPerfilBytes == null)
                    Positioned.fill(
                      child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/imagens/imagem_perfil/perfil.png'),
                    ),
                  Center(
                    child: IconButton(
                      onPressed: () async {
                        final XFile? image = await logicaCadastrar.picker
                            .pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          image.readAsBytes().then((bytes) {
                            setState(() {
                              logicaCadastrar.imagemPerfilBytes = bytes;
                              logicaCadastrar.corCamera =
                                  widgetsCustomizado.customColor();
                            });
                          });
                        } else {
                          setState(() {
                            logicaCadastrar.imagemPerfilBytes = null;
                            logicaCadastrar.corCamera = Colors.black;
                          });
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        size: 40,
                        color: logicaCadastrar.corCamera,
                      ),
                    ),
                  )
                ])),
              ),
              const SizedBox(
                height: 30,
              ), // NOME COMPLETO
              Row(
                children: [
                  Checkbox(
                      activeColor: widgetsCustomizado.customColor(),
                      value: logicaCadastrar.termosDeUso,
                      onChanged: (bool? value) {
                        setState(() {
                          logicaCadastrar.termosDeUso = value!;
                        });
                      }),
                  Flexible(
                      child: Text('Sim, eu aceito termos de uso do motorista',
                          style: GoogleFonts.mulish(fontSize: 18))),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: widgetsCustomizado.customColor(),
                      value: logicaCadastrar.politica,
                      onChanged: (bool? value) {
                        setState(() {
                          logicaCadastrar.politica = value!;
                        });
                      }),
                  Flexible(
                      child: Text(
                          'Sim, eu aceito termos de politica de privacidade',
                          style: GoogleFonts.mulish(fontSize: 18))),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  width: double.infinity,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            widgetsCustomizado.customColor(),
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: widgetsCustomizado.customColor(),
                                    ),
                                    const SizedBox(width: 20),
                                    const Text("Carregando..."),
                                  ],
                                ),
                              );
                            },
                          );
                          if (logicaCadastrar.politica &&
                              logicaCadastrar.termosDeUso) {
                            if (logicaCadastrar.imagemPerfilBytes != null) {
                              if (logicaCadastrar.erros.isEmpty) {
                                if (int.parse(
                                        logicaCadastrar.anoControle.text) >=
                                    2010) {
                                  bool retorno =
                                      await logicaCadastrar.registerUser(
                                          logicaCadastrar.emailControle.text,
                                          logicaCadastrar.senhaControle.text);
                                  if (retorno) {
                                    retornobd = await database
                                        .setCadastrarUsuario(context);
                                  } else {
                                    retornobd = false;
                                  }
                                  Navigator.of(context).pop();
                                  if (retorno && retornobd) {
                                    logicaGeral.navigateTo(
                                        context: context,
                                        destination: Sucesso(),
                                        tipo: 'pushreplacement');
                                  } else {
                                    QuickAlert.show(
                                      context: context,
                                      title:
                                          'Parece que você deixou de selecionar algum dado!',
                                      type: QuickAlertType.warning,
                                      confirmBtnColor:
                                          widgetsCustomizado.customColor(),
                                      confirmBtnText: 'Selecionar agora',
                                      text:
                                          'Ficou faltando preencher algum dado, verifique e tente novamente!',
                                    );
                                  }
                                } else {
                                  Navigator.of(context).pop();
                                  QuickAlert.show(
                                    context: context,
                                    title: 'O ano do veículo deve ser superior ou igual a 2010',
                                    type: QuickAlertType.error,
                                    confirmBtnColor: widgetsCustomizado
                                        .customColor(),
                                    confirmBtnText: 'Verificar',
                                    text: 'Pela nossa política o ano do veículo deve ser superior ou igual a 2010, verificaremos todos os dados!',
                                  );
                                }
                              } else {
                                Navigator.of(context).pop();
                                QuickAlert.show(
                                  context: context,
                                  title:
                                      'Parece que você deixou de selecionar algum dado!',
                                  type: QuickAlertType.warning,
                                  confirmBtnColor:
                                      widgetsCustomizado.customColor(),
                                  confirmBtnText: 'Selecionar agora',
                                  text:
                                      'Ficou faltando preencher algum dado, verifique e tente novamente!',
                                );
                              }
                            } else {
                              Navigator.of(context).pop();
                              QuickAlert.show(
                                context: context,
                                title: 'Selecione uma foto do seu rosto!',
                                type: QuickAlertType.warning,
                                confirmBtnColor:
                                    widgetsCustomizado.customColor(),
                                confirmBtnText: 'Selecionar agora',
                                text:
                                    'Foto de perfil não selecionada, selecione uma foto de perfil mostrando seu rosto claramente!',
                              );
                            }
                          } else {
                            Navigator.of(context).pop();
                            QuickAlert.show(
                              context: context,
                              title:
                                  'Você precisa aceitar os termos do nosso app!',
                              type: QuickAlertType.error,
                              confirmBtnColor: widgetsCustomizado.customColor(),
                              confirmBtnText: 'Verificar',
                              text:
                                  'Para fazer parte da nossa plataforma você deve estar condizente com os termos de uso da nossa plataforma!',
                            );
                          }
                        },
                        child: Text(
                          'Cadastrar agora',
                          style: GoogleFonts.mulish(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
