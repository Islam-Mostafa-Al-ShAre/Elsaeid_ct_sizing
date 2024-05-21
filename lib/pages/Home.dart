// ignore: file_names
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();

  double? result = 0;
  myDilog(String text) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: 'Note',
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      desc: text,
    )..show();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Elsaeid CT Sizing",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: controller,
                decoration: textFieldBoxDec,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    myDilog("Enter Your Numbers");
                  } else {
                    solver();
                    setState(() {});
                  }
                },
                child: const Text("Solve")),
            const SizedBox(
              height: 50,
            ),
            Text(result.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ],
        ),
      ),
    );
  }

  solver() {
    List<String> numbersStr = [];
    List<double> numbers = [];

    double maxSum = 0;
    double sum = 0;
    double averageStartLast = 0;

    numbersStr.addAll(controller.text.split(","));
    // check if numbersStr contain numeric value only
    bool numbersStrIsNumeric = true;
    for (var i = 0; i < numbersStr.length; i++) {
      if (!isNumeric(numbersStr[i])) {
        numbersStrIsNumeric = false;
      }
    }

    if (!numbersStrIsNumeric) {
      return myDilog("Only Number And ','");
    }

    for (var element in numbersStr) {
      numbers.add(double.parse(element.trim()));
    }
    for (var i = 0; i < numbers.length; i++) {
      sum += numbers[i];
    }

    int j = -1;
    for (var i = 1; i < numbers.length; i++) {
      j++;
      if (numbers[j] > numbers[i]) {
        maxSum += numbers[j];
      } else {
        maxSum += numbers[i];
      }
    }

    double aveFirst = numbers[0] / 2;
    double aveLast = numbers[numbers.length - 1] / 2;
    if (aveFirst < 20) aveFirst = 20;
    if (aveLast < 20) aveLast = 20;
    averageStartLast = aveFirst + aveLast;

    const double multi = 1.25;
    result = (maxSum + sum + averageStartLast) * multi;
  }

  /// check if the string contains only numbers
  bool isNumeric(String str) {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    return _numeric.hasMatch(str);
  }

  InputDecoration textFieldBoxDec = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[800]),
      hintText: "Type Your Numbers Like This 124,145,213 ",
      fillColor: Colors.white70);
}
