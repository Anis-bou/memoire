import 'dart:convert';

import 'package:blogapp/responsive.dart';
import 'package:blogapp/screens/agence/detailepage2.dart';
import 'package:blogapp/screens/client/map/find_friends.dart';
import 'package:blogapp/screens/client/screens/DetailPage.dart';
import 'package:blogapp/screens/comment_screen.dart';
import 'package:blogapp/screens/custom/OptionButton.dart';
import 'package:blogapp/services/agence_service.dart';
import 'package:blogapp/services/client_service.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OffersListView1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OffersList1State();
  }
}

class _OffersList1State extends State<OffersListView1> {
  var _offers = [];
  bool _loading = true;
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
    return _loading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () {
              return _loadOffers();
            },
            child: Scaffold(
                body: Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVerticalSpace(padding),
                        addVerticalSpace(padding),
                        addVerticalSpace(padding),
                        Padding(
                          padding: sidePadding,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                child: const Image(
                                    image:
                                        AssetImage('assets/images/logo.png')),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                        addVerticalSpace(20),
                        addVerticalSpace(10),
                        Expanded(
                          child: Padding(
                            padding: sidePadding,
                            child: ListView.builder(
                              itemBuilder: _buildOfferItem,
                              itemCount: _offers.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    width: size.width,
                    child: Center(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => FindFriends()),
                              (route) => true);
                        },
                        height: 45,
                        minWidth: 130,
                        shape: const StadiumBorder(),
                        color: C_3,
                        child: Text(
                          AppLocalizations.of(context)!.go_to_map,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
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
                    OfferDetailsView1(offer_id: _offers[index]['id'])));
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
                            height: 220,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/sale.jpg'),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 220,
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
                            color: COLOR_GREY.withAlpha(20), width: 0.09)),
                    //CommentScreen
                    child: IconButton(
                      color: Colors.black87,
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
        _loading = _loading ? !_loading : _loading;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error ' + response.statusCode + ': ' + response.body),
      ));
    }
  }
}
