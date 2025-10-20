
import 'package:fluter_base/pages/bmr.dart';
import 'package:fluter_base/pages/profile.dart';
import 'package:fluter_base/pages/waterIntect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IdealbodyWeight.dart';
import 'bmi.dart';
import 'bodyfat.dart';
import 'calculator.dart';
import '../introPage/slidebarmenu.dart';

class homepage extends StatelessWidget {
  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  Profile()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: slidler(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        toolbarHeight: 40,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToProfile(context), // Calls the navigation function
        tooltip: 'Go to Profile',
        backgroundColor: Colors.teal,
        child: const Icon(Icons.person,color: Colors.white,), // Use a relevant icon
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,

        child: Column(
          children: [
            Text(
              'Calculators',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [

                bmiButton(),
                SizedBox(width: 20),

                calculatorButton(),
                SizedBox(height: 20),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  bodyfatButton(),
                  SizedBox(width: 20),

                  DailyWaterIntakeButton(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IdealBodyWeightButton(),
                  SizedBox(width: 20),

                  basic_calculatorButton(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 70,
                bottom: 50,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  // Column(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(
                  //         Icons.home_outlined,
                  //         size: 50,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     Text('Home', style: TextStyle(fontSize: 18)),
                  //   ],
                  // ),
                  // SizedBox(width: 80),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=>articles()));
                  //       },
                  //       icon: Icon(
                  //         Icons.article_outlined,
                  //         size: 50,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     Text('Articles', style: TextStyle(fontSize: 18)),
                  //   ],
                  // ),
                  SizedBox(width: 80),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class calculatorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BMRCalculatorPage()),
        );
      },
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/bmr.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class bmiButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => myHome()),
        );
      },
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/bmi.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class bodyfatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bodyfat()),
        );
      },
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/body_fat.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class DailyWaterIntakeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Waterintectpage()),
        );
      },
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/water.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class IdealBodyWeightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IBWCalculatorPage()),
        );
      },
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/weight.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class basic_calculatorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Calculator()),
        );
      },
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/calculator.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
