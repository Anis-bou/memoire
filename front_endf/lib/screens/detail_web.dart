import 'dart:convert';

import 'package:blogapp/screens/comment_screen.dart';
import 'package:blogapp/screens/custom/BorderIcon.dart';
import 'package:blogapp/services/agence_service.dart';
import 'package:blogapp/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../services/client_service.dart';
import '../../../utils/constants.dart';

class OfferDetailsView2 extends StatefulWidget {
  @override
  _OfferDetails2State createState() => _OfferDetails2State();
  final int offer_id;
  OfferDetailsView2({required this.offer_id});
}

class _OfferDetails2State extends State<OfferDetailsView2> {
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
            child: offer != null ? _buildFormFields() : Text('Loading...'),
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
        body: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addVerticalSpace(100),

                          Padding(
                            padding: sidePadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              offer['name_agence'].toString(),
                                              style:
                                                  themeData.textTheme.headline4,
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
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const BorderIcon(
                                          width: 140,
                                          height: 140,
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
                                addVerticalSpace(padding),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BorderIcon(
                                          width: 140,
                                          height: 140,
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
                                addVerticalSpace(padding),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BorderIcon(
                                          width: 140,
                                          height: 140,
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
                                addVerticalSpace(padding),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BorderIcon(
                                          width: 140,
                                          height: 140,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BorderIcon(
                                          width: 140,
                                          height: 140,
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
                          addHorizontalSpace(30),
                          addVerticalSpace(padding),

                          SizedBox(
                            height: 4,
                          ),
                          addVerticalSpace(padding),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: _buildGridView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return Center(
      child: Container(
        height: 700,
        width: 700,
        child: GridView.count(
          //mainAxisSpacing: 1,
          // scrollDirection: true,
          shrinkWrap: true,
          crossAxisCount: 1,
          childAspectRatio: 1,
          children: List.generate(offer['images'].length, (index) {
            return ClipRRect(
                child: Container(
              width: 500,
              height: 300,
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
