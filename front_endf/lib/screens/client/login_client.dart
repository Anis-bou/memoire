import 'package:blogapp/constant.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/Client.dart';

import 'package:blogapp/screens/client/register_client.dart';
import 'package:blogapp/screens/client/screens/HomeClient.dart';
import 'package:blogapp/services/client_service.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../responsive.dart';
import 'clientDrawer.dart';

class Login_client extends StatefulWidget {
  @override
  _Login_clientState createState() => _Login_clientState();
}

class _Login_clientState extends State<Login_client> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login_client(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as Client);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(Client client) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', client.token ?? '');
    await pref.setInt('userId', client.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const CustomClientDrawer()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              COLOR_1,
              COLOR_2,
              COLOR_3,
              COLOR_4,
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  if (Responsive.isWeb(context))
                    Expanded(flex: 2, child: Text('')),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.sign_in_as_client,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  if (Responsive.isMobile(context))
                    Expanded(
                        flex: 6,
                        child: Image.asset('assets/images/Login-cuate.png')),
                  Expanded(
                    flex: 6,
                    child: Form(
                      key: formkey,
                      child: ListView(
                        padding: EdgeInsets.all(32),
                        children: [
                          SizedBox(height: 50),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: txtEmail,
                              validator: (val) => val!.isEmpty
                                  ? AppLocalizations.of(context)!
                                      .plz_enter_email
                                  : null,
                              decoration: kInputDecoration(
                                  AppLocalizations.of(context)!.enter_email,
                                  Icons.email)),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: txtPassword,
                              obscureText: true,
                              validator: (val) => val!.length < 6
                                  ? AppLocalizations.of(context)!.require_6car
                                  : null,
                              decoration: kInputDecoration(
                                  AppLocalizations.of(context)!.enter_password,
                                  Icons.lock)),
                          SizedBox(
                            height: 20,
                          ),

                          /*
                          */
                          loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                        _loginUser();
                                      });
                                    }
                                  },
                                  height: 45,
                                  minWidth: 240,
                                  shape: const StadiumBorder(),
                                  color: COLOR_1,
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          /*Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => Register()),
                                (route) => false); */
                          kLoginRegisterHint(
                              AppLocalizations.of(context)!.dont_have_account,
                              AppLocalizations.of(context)!.register, () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Register_client()),
                                (route) => true);
                          })
                        ],
                      ),
                    ),
                  ),
                  if (Responsive.isWeb(context)) Expanded(child: Text('')),
                ],
              ),
            ),
            if (Responsive.isTablet(context))
              Expanded(
                  child: Image.asset('assets/images/signin-tab-client.png')),
            if (Responsive.isWeb(context))
              Expanded(
                  child: Image.asset('assets/images/sigin-web-client.png')),
          ],
        ),
      ),
    );
  }
}
