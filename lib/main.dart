import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_chat_app/screens/auth_screen.dart';
import 'package:first_chat_app/screens/search_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Future<Widget> userSignedIn() async {
  //   User? user = FirebaseAuth.instance.currectUser;
  //   if(user != null){
  //     return HomeScreen();
  //   }else{
  //     return AuthScreen();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(),
      // home: FutureBuilder(
      //   future: userSignedIn(),
      //   builder: (context,AsyncSnapshot<Widget> snapshot){
      //     if(snapshot.hasData){
      //       return snapshot.data!;
      //     }
      //     return Scaffold(
      //       body: Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //     )
      //   },
      // )
    );
  }
}
