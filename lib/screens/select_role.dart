import 'package:flutter/material.dart';
import 'package:pooly_task/colors.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/pooly-logo-transparent.png",
                width: 200,
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/riderSignup");
                    },
                    child: Card(
                      color: PoolyColors.lightBlue[0],
                      shadowColor: PoolyColors.darkBlue[0],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.travel_explore,
                              size: 50,
                            ),
                            Text("Yolcu"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:() {
                      Navigator.pushReplacementNamed(context, "/driver");
                    },
                    child: Card(
                      color: PoolyColors.lightBlue[0],
                      shadowColor: PoolyColors.darkBlue[0],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.drive_eta,
                              size: 50,
                            ),
                            Text("Sürücü"),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        )
      )
    );
  }
}