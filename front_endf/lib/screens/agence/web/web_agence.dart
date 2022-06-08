import 'dart:convert';

import 'package:blogapp/responsive.dart';
import 'package:blogapp/screens/agence/home.dart';
import 'package:blogapp/screens/client/map/mapbox.dart';

import 'package:blogapp/screens/comment_screen.dart';

import 'package:blogapp/screens/detail_web.dart';
import 'package:blogapp/services/agence_service.dart';
import 'package:blogapp/services/client_service.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class web_agence extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _web_agenceState();
  }
}

class _web_agenceState extends State<web_agence> {
  var _offers = [];

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Responsive(
      mobile: Home(),
      tablet: Home(),
      web: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(AppLocalizations.of(context)!.offers),
            ),
            backgroundColor: COLOR_2,
          ),
          body: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: mapbox(),
                        )),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: sidePadding,
                              child: GridView.count(
                                // mainAxisSpacing: 1,
                                crossAxisSpacing: 4,
                                // scrollDirection: true,
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                children:
                                    List.generate(_offers.length, (index) {
                                  return _buildOfferItem(context, index);
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildOfferItem(BuildContext context, int index) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OfferDetailsView2(offer_id: _offers[index]['id'])));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    /*'public/images/offers/33/dbZDu7uOhr4SBMM6OMSKQAN8UIgoYTPpkZamNDgP.jpg' */
                    child: _offers[index]['images'].isEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/sale.jpg'),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(getOfferImageUrl(
                                        _offers[index]['images'][0]['id'])),
                                    fit: BoxFit.cover)),
                          )),

                //zizou@gmail.com
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: COLOR_WHITE,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                        border: Border.all(
                            color: COLOR_GREY.withAlpha(40), width: 0.5)),
                    //CommentScreen
                    child: IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CommentScreen(postId: _offers[index]['id'])));
                      },
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(15),
            Row(
              children: [
                Text(
                  _offers[index]['price'].toString(),
                  style: themeData.textTheme.headline6,
                ),
                addHorizontalSpace(20),
                Text(
                  _offers[index]['addres'].toString(),
                  style: themeData.textTheme.bodyText2,
                ),
              ],
            ),
            Row(
              children: [
                addVerticalSpace(10),
                Text(
                  _offers[index]['categorie'].toString(),
                  style: themeData.textTheme.bodyText2,
                ),
                addHorizontalSpace(15),
                Text(
                  _offers[index]['area'].toString(),
                  style: themeData.textTheme.bodyText2,
                ),
                Text("m²"
                    //  style: themeData.textTheme.bodyText2,
                    ),
                addHorizontalSpace(100),
                Text(
                  _offers[index]['operation'].toString(),
                  style: const TextStyle(
                      color: C_3, fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _loadOffers() async {
    var response = await getData('/offers');
    if (response.statusCode == 200) {
      setState(() {
        _offers = json.decode(response.body);
        print(_offers);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error ' + response.statusCode + ': ' + response.body),
      ));
    }
  }
}
