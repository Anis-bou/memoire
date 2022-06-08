import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/screens/agence/edit_offer.dart';
import 'package:blogapp/screens/agence/home.dart';
import 'package:blogapp/screens/client/map/find_friends.dart';
import 'package:blogapp/screens/comment_screen.dart';
import 'package:blogapp/screens/custom/BorderIcon.dart';

import 'package:blogapp/services/agence_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:blogapp/utils/constants.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:blogapp/utils/widget_functions.dart';

class DetailPage extends StatelessWidget {
  final dynamic post;

  const DetailPage({Key? key, @required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void _handleDeletePost(int offerId) async {
      ApiResponse response = await Api.deleteOffer(offerId);
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }

    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text(AppLocalizations.of(context)!.cancel),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      Widget continueButton = TextButton(
        child: Text(AppLocalizations.of(context)!.delete),
        onPressed: () {
          _handleDeletePost(post.id ?? 0);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(AppLocalizations.of(context)!.delete_offer),
        content: Text(AppLocalizations.of(context)!.would_you_like),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    var offer;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final ThemeData themedata = Theme.of(context);
    final Size siz = MediaQuery.of(context).size;
    final double tileSize = size.width * 0.13;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: COLOR_WHITE,
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Image.asset(itemData["image"]),
                        Image(image: AssetImage('assets/images/image_2.jpg')),
                        Positioned(
                          width: size.width,
                          top: padding,
                          child: Padding(
                            padding: sidePadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: BorderIcon(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.keyboard_backspace,
                                      color: COLOR_BLACK,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(context);
                                  },
                                  child: BorderIcon(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.delete,
                                      color: COLOR_BLACK,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 30.0,
                                  width: 300.0,
                                  child: Divider(
                                    color: C_3,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${post.name_agence}',
                                    style: themeData.textTheme.headline4,
                                  ),
                                  addHorizontalSpace(60),
                                  Text(
                                    '${post.operation}',
                                    style: const TextStyle(
                                        color: C_3,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              addVerticalSpace(padding),
                              Row(
                                children: [
                                  Text(
                                    '${post.price}',
                                    style: themeData.textTheme.headline4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //zizou@gmail.com

                    addVerticalSpace(padding),

                    Padding(
                      padding: sidePadding,
                      child: Text(
                        AppLocalizations.of(context)!.house_info,
                        style: themeData.textTheme.headline5,
                      ),
                    ),
                    addVerticalSpace(padding),
                    Row(
                      children: [
                        Padding(
                          padding: sidePadding,
                          child: Text(
                            AppLocalizations.of(context)!.address,
                            style: themeData.textTheme.headline5,
                          ),
                        ),
                        addVerticalSpace(20),
                        Text(
                          '${post.addres}',
                          style: themeData.textTheme.headline6,
                        ),
                      ],
                    ),
                    addVerticalSpace(padding),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BorderIcon(
                                    width: tileSize,
                                    height: tileSize,
                                    child: ImageIcon(AssetImage(
                                        "assets/images/area-removebg-preview.png"))),
                                addVerticalSpace(15),
                                Text(
                                  '${post.area}',
                                  style: themeData.textTheme.headline6,
                                ),
                                addVerticalSpace(15),
                                Text(
                                  AppLocalizations.of(context)!.area,
                                  style: themeData.textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BorderIcon(
                                    width: tileSize,
                                    height: tileSize,
                                    child: ImageIcon(AssetImage(
                                        "assets/images/bathroom.png"))),
                                addVerticalSpace(15),
                                Text(
                                  '${post.bathrooms}',
                                  style: themeData.textTheme.headline6,
                                ),
                                addVerticalSpace(15),
                                Text(
                                  AppLocalizations.of(context)!.bathrooms,
                                  style: themeData.textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BorderIcon(
                                    width: tileSize,
                                    height: tileSize,
                                    child: ImageIcon(AssetImage(
                                        "assets/images/bedroomicon2.png"))),
                                addVerticalSpace(15),
                                Text(
                                  '${post.bedrooms}',
                                  style: themeData.textTheme.headline6,
                                ),
                                addVerticalSpace(15),
                                Text(
                                  AppLocalizations.of(context)!.bedrooms,
                                  style: themeData.textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BorderIcon(
                                    width: tileSize,
                                    height: tileSize,
                                    child: ImageIcon(AssetImage(
                                        "assets/images/kitchenicon2.png"))),
                                addVerticalSpace(15),
                                Text(
                                  '${post.kitchen}',
                                  style: themeData.textTheme.headline6,
                                ),
                                addVerticalSpace(15),
                                Text(
                                  AppLocalizations.of(context)!.kitchen,
                                  style: themeData.textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BorderIcon(
                                    width: tileSize,
                                    height: tileSize,
                                    child: ImageIcon(AssetImage(
                                        "assets/images/téléchargement-removebg-preview.png"))),
                                addVerticalSpace(15),
                                Text(
                                  '${post.garage}',
                                  style: themeData.textTheme.headline6,
                                ),
                                addVerticalSpace(15),
                                Text(
                                  AppLocalizations.of(context)!.garage,
                                  style: themeData.textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(padding),

                    Padding(
                      padding: sidePadding,
                      child: Text(AppLocalizations.of(context)!.location,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 23)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Tooltip(
                            message: 'double tap to open',
                            preferBelow: false,
                            child: InkWell(
                              onDoubleTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FindFriends(),
                                    ));
                              },
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: BoxDecoration(color: COLOR_2),
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/googlemaps.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(
                        '${post.description}',
                        textAlign: TextAlign.justify,
                        style: themeData.textTheme.bodyText2,
                      ),
                    ),
                    addVerticalSpace(150),

                    SizedBox(
                      height: 20.0,
                    ),
                    Positioned(
                      bottom: 30,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addHorizontalSpace(15),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addHorizontalSpace(15),
                    MaterialButton(
                      onPressed: () {
                        FlutterPhoneDirectCaller.callNumber(
                            '${post.numberphone}');
                      },
                      height: 45,
                      minWidth: 240,
                      shape: const StadiumBorder(),
                      color: C_3,
                      child: Text(
                        AppLocalizations.of(context)!.call,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InformationTile extends StatelessWidget {
  final String content;
  final String name;

  const InformationTile({Key? key, required this.content, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width * 0.20;
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BorderIcon(
              width: tileSize,
              height: tileSize,
              child: Text(
                content,
                style: themeData.textTheme.headline6,
              )),
          addVerticalSpace(15),
          Text(
            name,
            style: themeData.textTheme.headline6,
          )
        ],
      ),
    );
  }
}

    /**/