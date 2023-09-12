import 'package:flutter/material.dart';

import 'LoginPage.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "Welcome To ChatBox",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 29,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/8,
            ),
            Image.asset("assets/1.png",color: Colors.greenAccent[700],
            height: 340,
            width: 340),
            SizedBox(
              height: MediaQuery.of(context).size.height/9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 17
                ),
                children:[
                  TextSpan(text: "Agree and Continue to accept the",
                  style: TextStyle(
                    color: Colors.grey[600],
                  )),
                  TextSpan(text: "KothaApp terms of Service and Privacy Policy",
                  style: TextStyle(
                    color: Colors.cyan
                  )),
                ]
              )),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => LoginPage()), (route) => false);
                },
              child: Container(
                width: MediaQuery.of(context).size.width - 110,
                height: 50,
                child: Card(
                  margin: const EdgeInsets.all(8),
                    elevation: 8,
                    color: Colors.greenAccent[400],
                    child: Center(
                        child: Text(
                            "AGREE AND CONTINUE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                          ),
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
