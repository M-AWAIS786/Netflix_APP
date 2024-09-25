import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practicenetflix/pages/download.dart';
import 'package:practicenetflix/pages/home.dart';
import 'package:practicenetflix/pages/news_hot.dart';
import 'package:practicenetflix/pages/search.dart';
import 'package:practicenetflix/widget_pages/bottom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black,brightness: Brightness.dark,)
              .copyWith(background: Colors.black),
          textTheme: TextTheme(
            titleLarge: GoogleFonts.roboto(
              fontSize: 30,
            ),
            bodyMedium: GoogleFonts.roboto(),
            displaySmall: GoogleFonts.roboto(),
          )),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
//*** *** ***      Bottom App NAV BAR   ***** *****  //////
  static final List<Widget> screens = [
    const Home(),
    const newshot(),
    const search(),
    const download(),
  ];
  int selectedindex=0;
     void tappedindex(int index){
          setState(() {
            selectedindex=index;
          });
      }

///// ***** ****** ***** end bottombar functionality ***** //////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            navBarItem(context,Icons.home,'Home',0,tappedindex),
            navBarItem(context,Icons.video_collection,'News & Hot',1,tappedindex),
            navBarItem(context,Icons.search_rounded,'Search',2,tappedindex),
            navBarItem(context,Icons.download_for_offline_outlined,'Download',3,tappedindex),
          ],
        ),
      ),
        body:screens[selectedindex],

    );

  }




}
