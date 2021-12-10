import 'package:appcupboard/services/notifications_service.dart';
import 'package:appcupboard/services/services.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:appcupboard/providers/login_form_provider.dart';

import 'package:appcupboard/widgets/authetication/wave_widget.dart';
import 'package:appcupboard/shared/globals_color_login.dart';
import 'package:appcupboard/iu/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: GlobalColorLogin.white,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            height: size.height - 200,
            color: GlobalColorLogin.mediumBlue,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: GlobalColorLogin.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    color: GlobalColorLogin.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 380.0, left: 10, right: 10),
              child: ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForm())),
          Padding(
            padding: EdgeInsets.only(top: 570.0, left: 105),
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo[600]),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                'Crear nueva cuenta',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'register'),
            ),
          )
        ]),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'maria.kjh@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no tiene un formato de un correo';
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              //autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser mayor a 6 caracteres';
              },
            ),
            SizedBox(height: 15),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.indigo[600],
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Wait...' : 'Login',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus(); // quitar el teclado.
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        final String? errorMenssage = await authService.login(
                            loginForm.email, loginForm.password);

                        if (errorMenssage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          NotificationsService.showSnackbar(errorMenssage);
                          loginForm.isLoading = false;
                        }

                        loginForm.isLoading = false;
                      })
          ],
        ),
      ),
    );
  }
}
