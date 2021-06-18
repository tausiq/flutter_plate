import 'package:flutter/material.dart';
import 'package:flutter_plate/constants/Assets.dart';
import 'package:flutter_plate/reg/ui/design2/register_page_2.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';

import 'login_page_2.dart';

class LandingPage2 extends StatefulWidget {
  static String tag = 'landing-page';
  @override
  _LandingPage2State createState() => _LandingPage2State();
}

class _LandingPage2State extends State<LandingPage2> with TickerProviderStateMixin {
  PageController _controller = PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _controller,
            physics: AlwaysScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            children: <Widget>[
              LoginPage2(
                userRepository: FirebaseUserRepository(),
                navCallback: _gotoRegPage,
              ),
              landingPage(),
              RegisterPage2(_gotoLoginPage)
            ],
            scrollDirection: Axis.horizontal,
          )),
    );
  }

  _onPageChanged(int index) {
    if (index == 1) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  _gotoLoginPage() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  _gotoRegPage() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  Widget landingPage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          image: DecorationImage(
            colorFilter:
                ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage(Assets.bgLogin),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 120.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 24.0,
                child: Image.asset(Assets.appLogo),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Flutter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "Plate",
                    style: TextStyle(
                        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Theme.of(context).accentColor,
                      highlightedBorderColor: Colors.white,
                      onPressed: () => _gotoRegPage(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: () => _gotoLoginPage(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "LOGIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
