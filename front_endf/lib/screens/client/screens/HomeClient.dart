import 'package:blogapp/screens/client/profile_client/profile.dart';

import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/widget_functions.dart';
import 'package:flutter/material.dart';

import '../map/find_friends.dart';
import 'dashboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home_client extends StatefulWidget {
  @override
  _Home_clientState createState() => _Home_clientState();
}

class _Home_clientState extends State<Home_client> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    OffersListView(),
    //favorites(),
    //Profile(),
    Profile(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = OffersListView(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: COLOR_2,
        child: Icon(Icons.map),
        onPressed: () {
          setState(() {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => FindFriends()),
                (route) => true);
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  addHorizontalSpace(60),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            OffersListView(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? COLOR_2 : Colors.grey,
                        ),
                        Text(
                          AppLocalizations.of(context)!.home_page,
                          style: TextStyle(
                            color: currentTab == 0 ? COLOR_2 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            favorites(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: currentTab == 3 ? C_3 : Colors.grey,
                        ),
                        Text(
                          'Favorites',
                          style: TextStyle(
                            color: currentTab == 3 ? C_3 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //yazid@gmail.com
                  /* MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Profile(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 1 ? C_3 : Colors.grey,
                        ),
                        Text(
                          'Chats',
                          style: TextStyle(
                            color: currentTab == 1 ? C_3 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Profile(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: currentTab == 2 ? COLOR_2 : Colors.grey,
                        ),
                        Text(
                          AppLocalizations.of(context)!.profile,
                          style: TextStyle(
                            color: currentTab == 2 ? COLOR_2 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  addHorizontalSpace(60),
                ],
              )
              // addHorizontalSpace(35),
            ],
          ),
        ),
      ),
    );
  }
}
