import 'package:flutter/material.dart';

import 'homepage.dart';

class Waterintectpage extends StatefulWidget {
  const  Waterintectpage({Key? key}) : super(key: key);

  @override
  State< Waterintectpage> createState() =>_WiCalculatorPageState();
}

class _WiCalculatorPageState extends State< Waterintectpage> {

  String weightUnit = 'kg';


  final TextEditingController weightController = TextEditingController();
  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  double calculateBMR() {
    try {
      double weightInKg = 0;
      // Convert weight to kg
      if (weightUnit == 'kg') {
        weightInKg = double.parse(weightController.text);
        return 35* weightInKg;
      } else {
        // Convert lb to kg
        weightInKg = double.parse(weightController.text) * 0.453592;
        return 35* weightInKg;
      }


    } catch (e) {
      return 0;
    }
  }

  void showResult() {
    double water = calculateBMR();
    if (water > 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Your Daily Water Intake '),
          content: Text(
            '${water.toStringAsFixed(0)} ml/day',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF91ADF6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF91ADF6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF052163), size: 32),
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context){return homepage();}),);},
        ),
        title: const Text(
          'Daily Water Intake',
          style: TextStyle(
            color: Color(0xFF052163),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
         child: Column(
           children: [
             Text(
              'Weight',
              style: TextStyle(
                color: Color(0xFF052163),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
                   ),
             SizedBox(height: 12),
             Row(
               children: [
                 Expanded(
                   flex: 3,
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(15),
                     ),
                     child: TextField(
                       controller: weightController,
                       keyboardType: TextInputType.number,
                       textAlign: TextAlign.center,
                       style: const TextStyle(
                         fontSize: 24,
                         color: Color(0xFF052163),
                       ),
                       decoration: InputDecoration(
                         hintText: weightUnit == 'kg' ? 'Kilograms' : 'Pounds',
                         hintStyle: const TextStyle(color: Color(0xFF052163)),
                         border: InputBorder.none,
                         contentPadding: const EdgeInsets.all(20),
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(width: 12),
                 GestureDetector(
                   onTap: () {
                     showDialog(
                       context: context,
                       builder: (context) => AlertDialog(
                         title: const Text('Select Weight Unit'),
                         content: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             ListTile(
                               title: const Text('Kilograms (kg)'),
                               onTap: () {
                                 setState(() => weightUnit = 'kg');
                                 Navigator.pop(context);
                               },
                             ),
                             ListTile(
                               title: const Text('Pounds (lb)'),
                               onTap: () {
                                 setState(() => weightUnit = 'lb');
                                 Navigator.pop(context);
                               },
                             ),
                           ],
                         ),
                       ),
                     );
                   },
                   child: Container(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(15),
                     ),
                     child: Row(
                       children: [
                         Text(
                           weightUnit,
                           style: const TextStyle(
                             fontSize: 20,
                             color: Color(0xFF052163),
                           ),
                         ),
                         const SizedBox(width: 8),
                         const Icon(Icons.arrow_drop_down, color: Color(0xFF052163)),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
             SizedBox(height: 24),
             SizedBox(
               width: double.infinity,
               height: 60,
               child: ElevatedButton(
                 onPressed: showResult,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF052163),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),
                   ),
                 ),
                 child: const Text(
                   'Calculate',
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),

    );
  }
}