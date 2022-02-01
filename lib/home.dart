import 'package:flutter/material.dart';
import 'package:google/function.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){
                  createUserFromGoogle();
                },
                child: const Text(
                  "Google Sign in",
                  style: TextStyle(
                    fontSize: 30
                  ),
                )
            ),
            const SizedBox(height: 20,),
            TextButton(
                onPressed: (){
                  createUserFromFacebook();
                },
                child: const Text(
                  "Facebook Sign in",
                  style: TextStyle(
                      fontSize: 30
                  ),
                )
            ),
            const SizedBox(height: 20,),
            TextButton(
                onPressed: ()async{
                  await logOut();
                },
                child: const Text(
                  "LogOut",
                  style: TextStyle(
                      fontSize: 30
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
