import 'package:blogapp/constant.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/Client.dart';

import 'package:blogapp/screens/client/login_client.dart';
import 'package:blogapp/screens/client/screens/HomeClient.dart';
import 'package:blogapp/services/client_service.dart';
import 'package:blogapp/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../responsive.dart';
import 'clientDrawer.dart';

class Register_client extends StatefulWidget {
  @override
  _Register_clientState createState() => _Register_clientState();
}

class _Register_clientState extends State<Register_client> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register_client(
        nameController.text, emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as Client);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // Save and redirect to home
  void _saveAndRedirectToHome(Client client) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', client.token ?? '');
    await pref.setInt('userId', client.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CustomClientDrawer()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.sign_up_as_client,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  if (Responsive.isMobile(context))
                    Expanded(
                        flex: 5,
                        child:
                            Image.asset('assets/images/Mobile login-pana.png')),
                  Expanded(
                    flex: 6,
                    child: Form(
                      key: formKey,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 10),
                        children: [
                          TextFormField(
                              controller: nameController,
                              validator: (val) => val!.isEmpty
                                  ? AppLocalizations.of(context)!.plz_enter_name
                                  : null,
                              decoration: kInputDecoration(
                                  AppLocalizations.of(context)!.name,
                                  Icons.person)),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
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
                              controller: passwordController,
                              obscureText: true,
                              validator: (val) => val!.length < 6
                                  ? AppLocalizations.of(context)!.require_6car
                                  : null,
                              decoration: kInputDecoration(
                                  AppLocalizations.of(context)!.enter_password,
                                  Icons.lock)),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: passwordConfirmController,
                              obscureText: true,
                              validator: (val) => val != passwordController.text
                                  ? AppLocalizations.of(context)!
                                      .confirmed_pass_dont_match
                                  : null,
                              decoration: kInputDecoration(
                                  AppLocalizations.of(context)!.confirm_pass,
                                  Icons.lock)),
                          SizedBox(
                            height: 20,
                          ),
                          loading
                              ? Center(child: CircularProgressIndicator())
                              : MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = !loading;
                                        _registerUser();
                                      });
                                    }
                                  },
                                  height: 45,
                                  minWidth: 240,
                                  shape: const StadiumBorder(),
                                  color: COLOR_1,
                                  child: Text(
                                    AppLocalizations.of(context)!.register,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          kLoginRegisterHint(
                              AppLocalizations.of(context)!
                                  .already_have_account,
                              AppLocalizations.of(context)!.login, () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Login_client()),
                                (route) => false);
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
                  child: Image.asset('assets/images/signup-tab-agence.png')),
            if (Responsive.isWeb(context))
              Expanded(
                  child: Image.asset('assets/images/signup-web-client.png')),
          ],
        ),
      ),
    );
  }
}
