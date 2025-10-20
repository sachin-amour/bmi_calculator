import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'homepage.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<Calculator> {
  String userInput = '0';
  String result = '';

  // Array of button values. The order defines the layout.
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.black,
        appBar: AppBar(
        backgroundColor: const Color(0xFF0C0C0C),
    elevation: 0,
    toolbarHeight: 33,
    leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Color(0xFFF4F4F8), size: 32),
    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context){return homepage();}),);},
    ),
    title: const Text(
    'Calculator',
    style: TextStyle(
    color: Color(0xFFF1F3F8),
    fontSize: 28,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Calculator Display Area
            Expanded(
              flex: 1, // Takes up 1/3 of the space
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 28.0,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userInput,
                      style: const TextStyle(
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons Grid
            Expanded(
              flex: 2, // Takes up 2/3 of the space
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.0, // Ensures buttons are square
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CalculatorButton(
                    text: buttons[index],
                    buttonTapped: () => onButtonTapped(buttons[index]),
                    color: getButtonColor(buttons[index]),
                    textColor: getTextColor(buttons[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------- LOGIC FUNCTIONS -------------------------

  void onButtonTapped(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        userInput = '';
        result = '';
      } else if (buttonText == '+/-') {
        // Toggles the sign if the current input is a valid number
        if (double.tryParse(userInput) != null) {
          double val = double.parse(userInput);
          userInput = (-val).toString();
          /*- double.tryParse(userInput) != null: Checks if userInput can be
           parsed into a double. Prevents runtime errors.
          - double.parse(userInput): Converts the string to a double.
          - (-val).toString(): Negates the value and converts it back to a string.
            - userInput = ...: Updates userInput with the negated value.
          */
        }
      } else if (buttonText == '%') {
        userInput += '/100';
      } else if (buttonText == '=') {
        calculate();
      } else {
        // Prevents leading zeros unless it's a decimal (e.g., "0" -> "4" should be "4", not "04")
        if (userInput == '' && int.tryParse(buttonText) == 0) {
          userInput = '0'; // Allow starting with 0, but don't append more.
        } else if (userInput == '0' && buttonText != '.') {
          userInput = buttonText; // Replace initial '0' with the first digit
        } else {
          userInput += buttonText;
        }
      }
    });
  }

  void calculate() {
    String finalInput = userInput;
    // Replace 'x' with '*' for the math_expressions parser
    finalInput = finalInput.replaceAll('x', '*');

    try {
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, cm);
      /*
      *- GrammarParser() creates a parser instance.
      * - p.parse(finalInput) converts the string into an expression tree.
      * - ContextModel() provides variable context (not used here, but required).
      * - exp.evaluate(...) computes the result as a double.
      *
      */

      // Simple formatting to clean up results
      if (eval % 1 == 0) {
        // Check if it's an integer (e.g., 5.0)
        result = eval.toInt().toString();
      } else {
        // Restrict to a few decimal places if needed
        result = eval.toStringAsFixed(8);
        // Remove trailing zeros (e.g., 5.120000 -> 5.12)
        result = result.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
      }

      // Update userInput to the result so further operations can be chained
      userInput = result;
    } catch (e) {
      result = 'Error';
      userInput = ''; // Clear input on error
    }
  }

  // ------------------------- STYLING FUNCTIONS -------------------------

  Color getButtonColor(String text) {
    if (['÷', 'x', '-', '+', '='].contains(text)) {
      return Colors.orange;
    }
    if (['C', '+/-', '%'].contains(text)) {
      // Light gray for the top-row special functions
      return Colors.grey.shade700;
    }
    // Dark gray for numbers
    return Colors.grey.shade900;
  }

  Color getTextColor(String text) {
    if (['C', '+/-', '%'].contains(text)) {
      // Dark text for the light gray buttons
      return Colors.black;
    }
    // White text for all other buttons
    return Colors.white;
  }
}

// ------------------------- CUSTOM WIDGET -------------------------

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback buttonTapped;
  final Color color;
  final Color textColor;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.buttonTapped,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    // Use an ElevatedButton with a circular shape for better visuals and tap feedback
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: buttonTapped,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
