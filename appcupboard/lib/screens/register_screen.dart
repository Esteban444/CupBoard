import 'package:appcupboard/services/notifications_service.dart';
import 'package:appcupboard/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appcupboard/providers/register_form_provider.dart';

import 'package:appcupboard/widgets/authetication/wave_widget.dart';
import 'package:appcupboard/shared/globals_color_login.dart';

import 'package:appcupboard/iu/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
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
                  'Check In',
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
              padding: EdgeInsets.only(top: 330.0, left: 10, right: 10),
              child: ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child: _RegisterForm())),
          Padding(
            padding: EdgeInsets.only(top: 650.0, left: 105),
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo[600]),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                'Regresar al login',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            ),
          )
        ]),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  prefixIcon: Icons.person_pin_circle),
              onChanged: (value) => registerForm.nombreCompleto = value,
              validator: (value) {
                return (value != null && value.length >= 3)
                    ? null
                    : 'El nombre debe de ser mayor a 3 caracteres';
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'UserName',
                  labelText: 'UserName',
                  prefixIcon: Icons.verified_user),
              onChanged: (value) => registerForm.userName = value,
              validator: (value) {
                return (value != null && value.length >= 3)
                    ? null
                    : 'El nombre de usuario debe de ser mayor a 3 caracteres';
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'maria.ruiz@gmail.com',
                  labelText: 'Email',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => registerForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => registerForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 10),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.indigo[600],
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: registerForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!registerForm.isValidForm()) return;

                        final String? errorMenssage =
                            await authService.createUser(
                                registerForm.nombreCompleto,
                                registerForm.userName,
                                registerForm.email,
                                registerForm.password);

                        if (errorMenssage == null) {
                          Navigator.pushReplacementNamed(context, 'login');
                        } else {
                          NotificationsService.showSnackbar(errorMenssage);
                          registerForm.isLoading = false;
                        }
                      })
          ],
        ),
      ),
    );
  }
}
