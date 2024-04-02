import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Sucesso extends StatelessWidget {
  const Sucesso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Lottie.asset(
                'assets/lotties/sucess.json',
                width: MediaQuery.of(context).size.width * 0.3,
              )),
              Text(
                textAlign: TextAlign.center,
                'Cadastro realizado com sucesso!',
                style: GoogleFonts.mulish(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                textAlign: TextAlign.center,
                'Seu cadastro foi aprovado pela nossa IA, porém qualquer inconsistência em seu cadastro será mediado pela nossa equipe!!',
                style: GoogleFonts.mulish(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 50,),
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () async {

                            final Uri _url = Uri.parse('https://apps.apple.com/br/app/fuifui-motoristas/id6475738750');
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFFf19a08),
                              ),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/imagens/appstore.png'),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () async {

                            final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=com.fuifui.motoristas.mobilidade_urbana_motoristas');
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }

                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFFf19a08),
                              ),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/imagens/playstore.png'),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
