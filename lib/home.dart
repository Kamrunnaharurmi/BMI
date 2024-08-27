import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _weightUnit = "kg";
  String _heightUnit = "m";
  double _bmi = 0.0;
  String _result = "";

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      double weightInKg = weight;
      double heightInM = height;

      if (_weightUnit == "lb") {
        weightInKg = weight * 0.453592;
      }

      if (_heightUnit == "cm") {
        heightInM = height / 100;
      } else if (_heightUnit == "ft") {
        final feetAndInches = _heightController.text.split(" ");
        final feet = double.tryParse(feetAndInches[0]);
        final inches = feetAndInches.length > 1
            ? double.tryParse(feetAndInches[1])
            : 0.0;
        if (feet != null && inches != null) {
          heightInM = (feet * 0.3048) + (inches * 0.0254);
        } else {
          _result = "Please enter a valid height.";
          setState(() {});
          return;
        }
      }

      final bmi = weightInKg / (heightInM * heightInM);
      setState(() {
        _bmi = bmi;
        if (bmi < 18.5) {
          _result = "Underweight";
        } else if (bmi < 24.9) {
          _result = "Normal weight";
        } else if (bmi < 29.9) {
          _result = "Overweight";
        } else {
          _result = "Obesity";
        }
      });
    } else {
      setState(() {
        _result = "Please enter valid weight and height.";
      });
    }
  }

  void _clearFields() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmi = 0.0;
      _result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/im.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              'BMI Calculator',
              style: GoogleFonts.abrilFatface(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'image/image.jpg',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.abrilFatface(color: Colors.black),
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelStyle: GoogleFonts.abrilFatface(
                                  fontSize: 15,
                                  color: Colors.black,
                                  backgroundColor: Colors.white,
                                ),
                                labelText: "Weight",
                                hintStyle: GoogleFonts.abrilFatface(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                hintText: "Enter Your Weight",
                                prefixIcon: Icon(Icons.monitor_weight,
                                    color: Colors.black, size: 20),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black),
                            ),
                            child: DropdownButton<String>(
                              value: _weightUnit,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _weightUnit = newValue!;
                                });
                              },
                              style: GoogleFonts.abrilFatface(color: Colors.black),
                              dropdownColor: Colors.white,
                              underline: SizedBox(),
                              items: <String>['kg', 'lb']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.abrilFatface(color: Colors.black),
                              controller: _heightController,
                              keyboardType: _heightUnit == 'ft'
                                  ? TextInputType.text
                                  : TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelStyle: GoogleFonts.abrilFatface(
                                  fontSize: 15,
                                  color: Colors.black,
                                  backgroundColor: Colors.white,
                                ),
                                labelText: "Height",
                                hintStyle: GoogleFonts.abrilFatface(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                hintText: _heightUnit == "ft"
                                    ? "Enter Your Height (ft in)"
                                    : "Enter Your Height",
                                prefixIcon: Icon(Icons.height,
                                    color: Colors.black, size: 20),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black),
                            ),
                            child: DropdownButton<String>(
                              value: _heightUnit,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _heightUnit = newValue!;
                                });
                              },
                              style: GoogleFonts.abrilFatface(color: Colors.black),
                              dropdownColor: Colors.white,
                              underline: SizedBox(),
                              items: <String>['m', 'cm', 'ft']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: _calculateBMI,
                        child: Text('Calculate BMI',
                            style: GoogleFonts.abrilFatface(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      SizedBox(height: 5),
                      if (_result.isNotEmpty) ...[
                        Text(
                          'Your BMI: ${_bmi.toStringAsFixed(2)}',
                          style: GoogleFonts.abrilFatface(fontSize: 20),
                        ),
                        Text(
                          _result,
                          style: GoogleFonts.abrilFatface(fontSize: 20, color: Colors.black),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: _clearFields,
                          child: Text('Clear',
                              style: GoogleFonts.abrilFatface(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
