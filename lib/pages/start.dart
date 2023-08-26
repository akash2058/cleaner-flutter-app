import 'dart:async';
import 'dart:math';

import 'package:cleaner/animation/FadeAnimation.dart';
import 'package:cleaner/models/service.dart';
import 'package:cleaner/pages/select_service.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Service> services = [
    Service('Basic cleaning',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Deep Cleaning',
        'https://cdn-icons-png.flaticon.com/512/8634/8634252.png'),
    Service('Office cleaning',
        'https://static.vecteezy.com/system/resources/previews/021/707/862/original/office-cleaning-icon-vector.jpg'),
    Service('Window Washing',
        'https://cdn-icons-png.flaticon.com/512/6410/6410098.png'),
    Service('Pressure washing',
        'https://static.vecteezy.com/system/resources/thumbnails/001/912/968/small/power-washer-pressure-washing-woodcut-retro-vector.jpg'),
    Service('Bathroom Cleaning',
        'https://cdn3.iconfinder.com/data/icons/cleaning-house-1/272/cleaning-house-005-512.png'),
  ];

  int? selectedService = 4;

  @override
  void initState() {
    // Randomly select from service list every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        selectedService = Random().nextInt(services.length);
      });
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeAnimation(
                      (1.0 + index) / 4,
                      serviceContainer(services[index].imageURL,
                          services[index].name, index));
                }),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                      1.5,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Center(
                          child: Text(
                            'Cleaner\nSit back, relax, and\nLet us handle the cleaning',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.5,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Center(
                          child: Text(
                            'We provide you with the best people to clean your home or office.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      )),
                  FadeAnimation(
                      1.5,
                      Padding(
                        padding: EdgeInsets.all(50.0),
                        child: MaterialButton(
                          elevation: 0,
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectService(),
                              ),
                            );
                          },
                          height: 55,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.white : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.blue.shade100
                : Colors.grey.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 30),
              SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 14),
              )
            ]),
      ),
    );
  }
}
