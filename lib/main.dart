import 'package:SDC/providers/auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import './helpers/Router.dart';
import './localization/localization.dart';
import './localization/language_constants.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  // set locale language
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // check the internet connection
  StreamSubscription<ConnectivityResult> subscription;
  bool _internetDisable=false;
  @override
  initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.none) {
        setState(() {
          _internetDisable = true;
        });
        //CircularProgressIndicator(),
      } else {
        setState(() {
          _internetDisable = false;
        });
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  // set locale language
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // track locale language changes
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _internetDisable
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 280.0),
                  child: Column(
                    children: <Widget>[
                      Text('No internet'),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Auth(),
              ),
            ],
            child: Consumer<Auth>(
              builder: (ctx, auth, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                // languages supports start
                supportedLocales: [
                  Locale("tr", "TR"),
                  Locale("en", "US"),
                ],
                locale: _locale,
                localizationsDelegates: [
                  DemoLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback:
                    (Locale locale, Iterable<Locale> supportedLocales) {
                  return locale;
                },
                // languages supports end
                title: 'SDC',
                theme: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  textTheme: TextTheme(
                    headline1: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    headline2: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 15,
                    ),
                    headline3: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 15,
                    ),
                    // profile
                    headline4: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                // routes
                // the default Router  is HomeScreen so no need to initial here
                //initialRoute: HomeScreen.routeName,
                onGenerateRoute: Router.generateRoute,
              ),
            ),
          );
  }
}
