import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puc_minas/app/core/constants/app_assets.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/login/login_controller.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cpfEC = TextEditingController();
  final passwordEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AppAssets.logo),
                const SizedBox(height: 40),
                TextFormField(
                  controller: cpfEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  validator: Validatorless.multiple([
                    Validatorless.cpf('O CPF é inválido'),
                    Validatorless.required('Este campo é obrigatório'),
                  ]),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Insira seu CPF'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordEC,
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.min(6, 'Mínimo de 6 caracteres'),
                    Validatorless.required('Este campo é obrigatório'),
                  ]),
                  decoration: const InputDecoration(
                    hintText: 'Insira sua senha',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    bool valid = formKey.currentState?.validate() ?? false;

                    if (valid) {
                      if (context.mounted) {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.info(message: 'Aguarde...'),
                        );
                      }

                      bool result = await LoginController.login(
                        cpf: cpfEC.text.replaceAll('.', '').replaceAll('-', ''),
                        senha: passwordEC.text,
                      );
                      if (result) {
                        if (context.mounted) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.success(
                              message: 'Login efetuado com sucesso',
                            ),
                          );
                        }
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
                        }
                      } else {
                        if (context.mounted) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: 'Login inválido',
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Acessar'),
                      SizedBox(width: 10),
                      Icon(Icons.login),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
