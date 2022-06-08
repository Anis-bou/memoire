import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/responsive.dart';
import 'package:blogapp/route.dart';

import 'package:blogapp/screens/agence/home.dart';
import 'package:blogapp/screens/agence/my_offer.dart';
import 'package:blogapp/screens/agence/profile.dart';
import 'package:blogapp/screens/agence/web/add_offerweb.dart';
import 'package:blogapp/screens/agence/web/web_agence.dart';
import 'package:blogapp/services/agence_service.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/widgets/language_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Agence_page extends StatefulWidget {
  const Agence_page({Key? key}) : super(key: key);

  @override
  Agence_pageState createState() => Agence_pageState();
}

class Agence_pageState extends State<Agence_page> {
  final _advancedDrawerController = AdvancedDrawerController();
  //final MenuController _controller = Get.put(MenuController());
  void _deletetoken() async {
    ApiResponse response = await Api.deletetoken();
    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const route()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Responsive(
        mobile: AdvancedDrawer(
          backdropColor: COLOR_2,
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Home(),
          drawer: SafeArea(
            child: Container(
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 64.0,
                        bottom: 64.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/logo1.png")),
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.language,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      onTap: () {},
                      leading: LanguagePickerWidget(),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person),
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Profile()),
                            (route) => true);
                      },
                      title: Text(
                        AppLocalizations.of(context)!.profile,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const route()),
                            (route) => false);
                      },
                      leading: Icon(Icons.logout),
                      title: Text(
                        AppLocalizations.of(context)!.log_out,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Text(AppLocalizations.of(context)!.terms),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        tablet: AdvancedDrawer(
          backdropColor: Colors.blueGrey.withOpacity(0.9),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Home(),
          drawer: SafeArea(
            child: Container(
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 64.0,
                        bottom: 64.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/user_2.png")),
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.language,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      onTap: () {},
                      leading: LanguagePickerWidget(),
                      /*title: Text(
                        AppLocalizations.of(context)!.home_page,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      ),*/
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person),
                      onTap: () {},
                      title: Text(
                        AppLocalizations.of(context)!.profile,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {},
                      leading: ImageIcon(
                        AssetImage("assets/images/favicon2.png"),
                        size: 24,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.favourite,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: ImageIcon(
                        AssetImage("assets/images/settingsicon.png"),
                        size: 24,
                      ),
                      onTap: () {},
                      title: Text(
                        AppLocalizations.of(context)!.settings,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => route()),
                            (route) => false);
                      },
                      leading: Icon(Icons.logout),
                      title: Text(
                        AppLocalizations.of(context)!.log_out,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Text(AppLocalizations.of(context)!.terms),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        web: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 29, 28, 28),
              title: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 50,
                width: 50,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: _deletetoken,
                )
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => web_add()),
                            (route) => true);
                      },
                      height: 45,
                      minWidth: 240,
                      shape: const StadiumBorder(),
                      color: C_3,
                      child: Text(
                        AppLocalizations.of(context)!.add_new_offer,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ), /**web_agence */
                  ),
                  ListTile(
                    title: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => web_agence()),
                            (route) => true);
                      },
                      height: 45,
                      minWidth: 240,
                      shape: const StadiumBorder(),
                      color: C_3,
                      child: Text(
                        AppLocalizations.of(context)!.offers,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ), /**web_agence */
                  ),
                ],
              ),
            ),
            body: myoffer()));
  }
}
/**AddOfferViewweb */
