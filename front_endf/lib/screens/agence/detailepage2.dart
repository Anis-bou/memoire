import 'dart:convert';

import 'package:blogapp/screens/client/map/find_friends.dart';
import 'package:blogapp/screens/comment_screen.dart';
import 'package:blogapp/screens/custom/BorderIcon.dart';
import 'package:blogapp/services/agence_service.dart';
import 'package:blogapp/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../services/client_service.dart';
import '../../../utils/constants.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfferDetailsView1 extends StatefulWidget {
  @override
  _OfferDetails1State createState() => _OfferDetails1State();
  final int offer_id;
  OfferDetailsView1({required this.offer_id});
}

class _OfferDetails1State extends State<OfferDetailsView1> {
  @override
  void initState() {
    super.initState();
    _loadOfferDetails();
  }

  var offer;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final ThemeData themedata = Theme.of(context);
    final Size siz = MediaQuery.of(context).size;
    final double tileSize = size.width * 0.13;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: offer != null
                ? _buildFormFields()
                : Text(AppLocalizations.of(context)!.loading),
          )
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final ThemeData themedata = Theme.of(context);
    final Size siz = MediaQuery.of(context).size;
    final double tileSize = size.width * 0.13;
    return SafeArea(
      child: Scaffold(
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
                        addVerticalSpace(padding),
                        // Image.asset(itemData["image"]),
                        offer['images'].isEmpty
                            ? Image(
                                image: AssetImage('assets/images/sale.jpg'),
                              )
                            : Image(
                                image: NetworkImage(
                                    getOfferImageUrl(offer['images'][0]['id'])),
                              ),
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
                                    FlutterPhoneDirectCaller.callNumber(
                                        offer['numberphone'].toString());
                                  },
                                  child: BorderIcon(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.phone,
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
                                  Row(
                                    children: [
                                      Text(
                                        offer['name_agence'].toString(),
                                        style: themeData.textTheme.headline4,
                                      ),
                                      addHorizontalSpace(60),
                                      Text(
                                        offer['operation'].toString(),
                                        style: const TextStyle(
                                            color: C_3,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              addVerticalSpace(padding),
                              Text(
                                offer['price'].toString(),
                                style: themeData.textTheme.headline4,
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
                          offer['addres'],
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
                                  offer['area'].toString(),
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
                                  offer['bathrooms'].toString(),
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
                                  offer['bedrooms'].toString(),
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
                                  offer['kitchen'].toString(),
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
                                  offer['garage'].toString(),
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
                      child: Text(AppLocalizations.of(context)!.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 23)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(
                        offer['description'].toString(),
                        textAlign: TextAlign.justify,
                        style: themeData.textTheme.bodyText2,
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
                      height: 20.0,
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
                        AppLocalizations.of(context)!.images,
                        style: themeData.textTheme.headline5,
                      ),
                    ),

                    _buildGridView(),
                    SizedBox(
                      height: 20,
                    ),
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
                          offer['numberphone'].toString(),
                        );
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

  Widget _buildGridView() {
    return Center(
      child: Container(
        height: 300,
        width: 350,
        child: GridView.count(
          //mainAxisSpacing: 1,
          // scrollDirection: true,
          shrinkWrap: true,
          crossAxisCount: 1,
          childAspectRatio: 1,
          children: List.generate(offer['images'].length, (index) {
            return ClipRRect(
                child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(getOfferImageUrl(
                    offer['images'][index]['id'])), /* fit: BoxFit.cover*/
              )),
            ));
          }),
        ),
      ),
    );
  }

  _loadOfferDetails() async {
    var response = await getData('/offers/' + widget.offer_id.toString());
    if (response.statusCode == 200) {
      setState(() {
        offer = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
