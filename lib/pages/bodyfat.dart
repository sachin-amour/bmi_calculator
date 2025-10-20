
import 'package:fluter_base/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bodyfat extends StatefulWidget {
  @override
  State<bodyfat> createState() => _mybodyfat();
}

class _mybodyfat extends State<bodyfat> {
  String selectedGender = 'Male';
  String weightUnit = 'kg';
  String heightUnit = 'ft-in';

  final TextEditingController weightController = TextEditingController();
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cmController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    feetController.dispose();
    inchController.dispose();
    cmController.dispose();
    ageController.dispose();
    super.dispose();
  }

  double calculateBfp() {
    try {
      double weightInKg = 0;
      double heightInCm = 0;
      double heightInMeter = 0;
      int age = int.parse(ageController.text);

      // Convert weight to kg
      if (weightUnit == 'kg') {
        weightInKg = double.parse(weightController.text);
      } else {
        // Convert lb to kg
        weightInKg = double.parse(weightController.text) * 0.453592;
      }

      // Convert height to cm
      if (heightUnit == 'ft-in') {
        int feet = int.parse(feetController.text);
        int inches = int.parse(inchController.text);
        heightInCm = (feet * 30.48) + (inches * 2.54);
        heightInMeter = heightInCm / 100;


      } else {
        heightInMeter = double.parse(cmController.text)/100;
      }

      // Mifflin-St Jeor Equation
      if (selectedGender == 'Male') {
        return weightInKg / (heightInMeter * heightInMeter);
      } else {
        return weightInKg / (heightInMeter * heightInMeter);
      }
    } catch (e) {
      return 0;
    }
  }

  void showResult() {
    int age = int.parse(ageController.text);
    double bmi = calculateBfp();
    double bfp=0;
    if(selectedGender=='male'){
      bfp=(1.2*bmi)+(0.23*age)-16.2;
    }else
      bfp= (1.2*bmi)+(0.23*age)-5.4;
    if (bfp > 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Your Body Fat Percentage %'),
          content: Text(
            '${bfp.toStringAsFixed(3)}',
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
      backgroundColor: const Color(0xFF93E3BA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF93E3BA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0E3523), size: 32),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){return homepage();}),);
          },
        ),
        title: const Text(
          'Body Mass Index',
          style: TextStyle(
            color: Color(0xFF0E3523),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gender',
              style: TextStyle(
                color: Color(0xFF0E3523),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGender = 'Male'),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: selectedGender == 'Male'
                            ? Colors.white
                            : Color.fromARGB(128, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(75),

                            child: Image.asset(
                              'assets/images/male3.png',
                              height: 150,

                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 80, color: Color(0xFF0E3523)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Male',
                            style: TextStyle(
                              color: const Color(0xFF0E3523),
                              fontSize: 20,
                              fontWeight: selectedGender == 'Male'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGender = 'Female'),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: selectedGender == 'Female'
                            ? Colors.white
                            : Color.fromARGB(128, 255, 255, 255) ,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.asset(
                              'assets/images/female3.png',
                              height: 120,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 80, color: Color(0xFF0E3523)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Female',
                            style: TextStyle(
                              color: selectedGender == 'Female'
                                  ? const Color(0xFF0E3523)
                                  : Color.fromARGB(128, 255, 255, 255) ,
                              fontSize: 20,
                              fontWeight: selectedGender == 'Female'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Weight',
              style: TextStyle(
                color: Color(0xFF0E3523),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
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
                        color: Color(0xFF0E3523),
                      ),
                      decoration: InputDecoration(
                        hintText: weightUnit == 'kg' ? 'Kilograms' : 'Pounds',
                        hintStyle: const TextStyle(color: Color(0xFF0E3523)),
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
                            color: Color(0xFF0E3523),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF0E3523)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Height',
              style: TextStyle(
                color: Color(0xFF0E3523),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (heightUnit == 'ft-in') ...[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: feetController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0E3523),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Feet',
                          hintStyle: TextStyle(color: Color(0xFF0E3523)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: inchController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0E3523),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'inch',
                          hintStyle: TextStyle(color: Color(0xFF0E3523)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: cmController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0E3523),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Centimeters',
                          hintStyle: TextStyle(color: Color(0xFF0E3523)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Select Height Unit'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('Feet-Inches (ft-in)'),
                              onTap: () {
                                setState(() => heightUnit = 'ft-in');
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Centimeters (cm)'),
                              onTap: () {
                                setState(() => heightUnit = 'cm');
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
                          heightUnit,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF0E3523),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF0E3523)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Age',
              style: TextStyle(
                color: Color(0xFF0E3523),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  color: Color(0xFF0E3523),
                ),
                decoration: const InputDecoration(
                  hintText: 'Years',
                  hintStyle: TextStyle(color: Color(0xFF0E3523)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: showResult,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E3523),
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
