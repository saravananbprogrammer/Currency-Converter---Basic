import 'package:flutter/material.dart';

class CurrencyConvertorMaterialPage extends StatefulWidget {
  const CurrencyConvertorMaterialPage({super.key});

  @override
  CurrencyConvertorMaterialPageState createState() =>
      CurrencyConvertorMaterialPageState();
}

class CurrencyConvertorMaterialPageState
    extends State<CurrencyConvertorMaterialPage> {
  // abstract class State<T extends StatefulWidget> with Diagnosticable
  bool _isHoveredConvert = false; // Hover state for "CONVERT" button
  bool _isHoveredRefresh = false; // Hover state for "REFRESH" button
  final FocusNode _textFieldFocusNode = FocusNode();
  bool _isFocused = false;
  final TextEditingController _controller = TextEditingController();
  double result = 0.0; // To store the converted result
  String? errorMessage; // To store error message

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode.addListener(() {
      setState(() {
        _isFocused = _textFieldFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _controller.dispose(); // Dispose the controller as well
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 7,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );

    final outBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 21, 1, 1),
        width: 0.1,
        style: BorderStyle.solid,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 255, 179),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 255, 179),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "CURRENCY CONVERTER",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result > 0
                  ? "₹${result.toStringAsFixed(3)}"
                  : "₹0.00", // Display result with INR symbol
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              width: 700,
              child: TextField(
                focusNode: _textFieldFocusNode,
                controller: _controller,
                onSubmitted: (value) => print(value),
                style: const TextStyle(
                  color: Color.fromRGBO(52, 255, 2, 0.875),
                  fontSize: 20.1,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Icon(
                      Icons.monetization_on_sharp,
                      size: 30.5,
                      color: _isFocused
                          ? const Color.fromARGB(255, 255, 217, 0)
                          : Colors.black87,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 30,
                  ),
                  enabledBorder: outBorder,
                  focusedBorder: border.copyWith(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 238, 0),
                      width: 5,
                    ),
                  ),
                  hoverColor: Colors.transparent,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            if (errorMessage != null) // Show error message if not null
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the box
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.red, // Border color
                    width: 2,
                  ),
                ),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredConvert = true),
              onExit: (_) => setState(() => _isHoveredConvert = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 217, 102),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: _isHoveredConvert
                      ? [
                          const BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            blurRadius: 26,
                            spreadRadius: 5,
                          ),
                        ]
                      : [],
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      final input = _controller.text.trim();
                      final usdAmount = double.tryParse(input);
                      if (usdAmount == null) {
                        setState(() {
                          errorMessage =
                              "Invalid input. Please enter a numeric value.";
                          result = 0.0; // Reset result on error
                        });
                      } else {
                        setState(() {
                          errorMessage = null; // Clear error message
                          result = usdAmount *
                              85.71; // Conversion logic (USD to INR)
                        });
                      }
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color.fromARGB(255, 109, 105, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      "CONVERT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredRefresh = true),
              onExit: (_) => setState(() => _isHoveredRefresh = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 100, // Reduced width
                height: 40, // Reduced height
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 217, 102),
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: _isHoveredRefresh
                      ? [
                          const BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            blurRadius: 7,
                            spreadRadius: 5,
                          ),
                        ]
                      : [],
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _controller.clear(); // Clear the input field
                      result = 0.0; // Reset the result
                      errorMessage = null; // Clear error message
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color.fromARGB(255, 109, 105, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    "REFRESH",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // Reduced font size
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
              child: Text("© 2025 SB Officials"),
            ),
          ],
        ),
      ),
    );
  }
}
