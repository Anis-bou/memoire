import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../responsive.dart';
import '../route.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants.dart';
import '../widgets/language_picker_widget.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}


class _OnboardingScreenState extends State<OnboardingScreen> {


  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white :  COLOR_1,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: LanguagePickerWidget(),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const route()),
                              (route) => false),
                      child: Text(
                        AppLocalizations.of(context)!.skip,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        //----------------------------------------------page1
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              if (Responsive.isMobile(context))
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                     const Expanded(
                                       flex: 4,
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/Onboarding-pana.png',
                                          ),

                                        ),
                                      ),
                                    if (Responsive.isMobile(context))
                                     Text(
                                        AppLocalizations.of(context)!.welcome_to_immobilia,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28),
                                      ),
                                    if (Responsive.isMobile(context))
                                      Text(
                                        AppLocalizations.of(context)!.onboard_we_make,
                                        style:  const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                      ),
                                    Expanded(child: Text(''))
                                  ],
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                Expanded(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/Onboarding-pana.png',
                                    ),

                                  ),
                                ),
                              if (!Responsive.isMobile(context))
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.welcome_to_immobilia,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 28),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.onboard_we_make,
                                          style:  const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5),
                                        ),

                                      ],
                                    ) ),
                            ],
                          ),
                        ),

                        //--------------------------------------page2

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    if (Responsive.isMobile(context))
                                      Text(
                                        AppLocalizations.of(context)!.buy_property ,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5
                                              ),
                                            ),
                                    if (Responsive.isMobile(context))
                                            Text(
                                              AppLocalizations.of(context)!.onboard_buy,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                    if (Responsive.isMobile(context))
                                            Text(
                                              AppLocalizations.of(context)!.sell_property,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.5),
                                            ),
                                    if (Responsive.isMobile(context))
                                            Text(
                                              AppLocalizations.of(context)!.onboard_sell,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                    if (Responsive.isMobile(context))
                                            Text(
                                              AppLocalizations.of(context)!.rent_property,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.5),
                                            ),
                                    if (Responsive.isMobile(context))
                                            Text(
                                              AppLocalizations.of(context)!.onboard_rent,
                                              style:TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                        const Expanded(
                                          child: Image(
                                            image: AssetImage(
                                              'assets/images/OnBoard2.png',
                                            ),

                                          ),
                                        ),


                                  ],
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                Expanded(
                                    child:SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.buy_property ,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                height: 1.5
                                            ),
                                          ),
                                            Text(
                                              AppLocalizations.of(context)!.onboard_buy,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.sell_property,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.5),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.onboard_sell,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.rent_property,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.5),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.onboard_rent,
                                              style:TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                        ],
                                      ),
                                    ),
                                ),
                            ],
                          ),
                        ),

                        //---------------------------------------page 3
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    if (Responsive.isMobile(context))
                                      Expanded(child: Text('')),
                                      if (Responsive.isMobile(context))
                                      Text(
                                        AppLocalizations.of(context)!.find_tour_take,
                                        style: TextStyle(
                                            fontSize: 46,
                                            fontWeight: FontWeight.w700),
                                    ),

                                    const Expanded(flex: 6,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/OnBoard3.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                Expanded(child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.find_tour_take,
                                    style: TextStyle(
                                        fontSize: 46,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),)

                            ],
                          ),
                        ),
                      ],
                    ),
                ),


                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),

                _currentPage != _numPages - 1
                    ?  Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.next,
                            style: const TextStyle(

                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          const Icon(
                            Icons.arrow_forward,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  )

                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Expanded(
            child: Container(
        height: 50.0,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
            onTap: () =>Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => route()),
                    (route) => false) , //print('Get Started'),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  AppLocalizations.of(context)!.get_started,
                  style: const TextStyle(
                    color: COLOR_1,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ),
      ),
          )
          : Text(''),
    );
  }
}