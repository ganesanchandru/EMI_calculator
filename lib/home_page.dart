import 'compare_emi.dart';
import 'emi_calculate.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EMICalculatorScreen()),
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(0, 45))
              ),
              child: const Text('EMI Calculate',style: TextStyle(fontSize: 18.0),),
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompareEMI()),
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(0, 45))
              ),
              child: const Text('Compare EMI',style: TextStyle(fontSize: 18.0),),
            ),
          ],
        ),
      ),
    );
  }
}
