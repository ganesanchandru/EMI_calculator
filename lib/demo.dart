// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PrincipalCalculatorScreen(),
//     );
//   }
// }
//
// class PrincipalCalculatorScreen extends StatefulWidget {
//   @override
//   _PrincipalCalculatorScreenState createState() => _PrincipalCalculatorScreenState();
// }
//
// class _PrincipalCalculatorScreenState extends State<PrincipalCalculatorScreen> {
//   TextEditingController _emiController = TextEditingController();
//   TextEditingController _interestRateController = TextEditingController();
//   TextEditingController _tenureController = TextEditingController();
//
//   double _principal = 0.0;
//
//   void _calculatePrincipal() {
//     double emi = double.tryParse(_emiController.text) ?? 0.0;
//     double interestRate = double.tryParse(_interestRateController.text) ?? 0.0;
//     int tenureInMonths = int.tryParse(_tenureController.text) ?? 0;
//
//     if (emi <= 0 || interestRate <= 0 || tenureInMonths <= 0) {
//       return; // Invalid input, do not calculate
//     }
//
//     double monthlyInterestRate = interestRate / 1200; // Convert percentage to decimal
//     double principal = (emi * (1 - (1 / pow(1 + monthlyInterestRate, tenureInMonths)))) / monthlyInterestRate;
//
//     setState(() {
//       _principal = principal;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Principal Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: _emiController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'EMI'),
//             ),
//             TextFormField(
//               controller: _interestRateController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Interest Rate (%)'),
//             ),
//             TextFormField(
//               controller: _tenureController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Loan Tenure (Months)'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _calculatePrincipal,
//               child: Text('Calculate Principal'),
//             ),
//             SizedBox(height: 20),
//             _principal > 0
//                 ? Text(
//               'Principal Amount: ₹${_principal.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: InterestCalculatorScreen(),
//     );
//   }
// }
//
// class InterestCalculatorScreen extends StatefulWidget {
//   @override
//   _InterestCalculatorScreenState createState() => _InterestCalculatorScreenState();
// }
//
// class _InterestCalculatorScreenState extends State<InterestCalculatorScreen> {
//   TextEditingController _emiController = TextEditingController();
//   TextEditingController _principalController = TextEditingController();
//   TextEditingController _tenureController = TextEditingController();
//
//   double _interestRate = 0.0;
//
//   void _calculateInterestRate() {
//     double emi = double.tryParse(_emiController.text) ?? 0.0;
//     double principal = double.tryParse(_principalController.text) ?? 0.0;
//     int tenureInMonths = int.tryParse(_tenureController.text) ?? 0;
//
//     if (emi <= 0 || principal <= 0 || tenureInMonths <= 0) {
//       return; // Invalid input, do not calculate
//     }
//
//     double interestRate = ((emi * tenureInMonths) / principal - 1) * 1200;
//
//     print('EMI: $emi');
//     print('Principal: $principal');
//     print('Tenure in Months: $tenureInMonths');
//     print('Interest Rate: $interestRate');
//
//     setState(() {
//       _interestRate = interestRate;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Interest Rate Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: _emiController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'EMI'),
//             ),
//             TextFormField(
//               controller: _principalController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Principal Amount'),
//             ),
//             TextFormField(
//               controller: _tenureController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Loan Tenure (Months)'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _calculateInterestRate,
//               child: Text('Calculate Interest Rate'),
//             ),
//             SizedBox(height: 20),
//             _interestRate > 0
//                 ? Text(
//               'Interest Rate: ${_interestRate.toStringAsFixed(2)}%',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'dart:math';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class LoanCalculator {
//   static int calculateTenure(double principal, double rate, double emi) {
//     double monthlyRate = rate / 12 / 100;
//     int totalMonths = 0;
//
//     if (monthlyRate != 0.0) {
//       totalMonths = (log(emi) - log(emi - principal * monthlyRate)) ~/ log(1 + monthlyRate);
//     }
//
//     int years = totalMonths ~/ 12;
//     int months = totalMonths % 12;
//
//     return years * 100 + months;
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Loan Tenure Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoanTenureScreen(),
//     );
//   }
// }
//
// class LoanTenureScreen extends StatefulWidget {
//   const LoanTenureScreen({Key? key}) : super(key: key);
//
//   @override
//   LoanTenureScreenState createState() => LoanTenureScreenState();
// }
//
// class LoanTenureScreenState extends State<LoanTenureScreen> {
//   final TextEditingController loanAmountController = TextEditingController();
//   final TextEditingController interestRateController = TextEditingController();
//   final TextEditingController emiController = TextEditingController();
//   String tenure = '';
//
//   void calculateTenure() {
//     double loanAmount = double.tryParse(loanAmountController.text) ?? 0.0;
//     double interestRate = double.tryParse(interestRateController.text) ?? 0.0;
//     double emi = double.tryParse(emiController.text) ?? 0.0;
//
//     int calculatedTenure = LoanCalculator.calculateTenure(loanAmount, interestRate, emi);
//
//     int years = calculatedTenure ~/ 100;
//     int months = calculatedTenure % 100;
//
//     setState(() {
//       tenure = '$years years $months months';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Loan Tenure Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: loanAmountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Loan Amount'),
//             ),
//             TextField(
//               controller: interestRateController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Interest Rate (%)'),
//             ),
//             TextField(
//               controller: emiController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'EMI'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: calculateTenure,
//               child: const Text('Calculate Tenure'),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Loan Tenure: $tenure',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class LoanCalculator {
//   double loanAmount = 0.0;
//   double interestRate = 0.0;
//   double emi = 0.0;
//
//   LoanCalculator(this.loanAmount, this.interestRate, this.emi);
//
//   String calculatePeriod() {
//     double monthlyInterest = (interestRate / 12) / 100;
//     double numberOfMonths = (loanAmount * monthlyInterest * pow(1 + monthlyInterest, emi)) /
//         (pow(1 + monthlyInterest, emi) - 1);
//     int years = (numberOfMonths / 12).floor();
//     int months = (numberOfMonths % 12).round();
//
//     return '$years years $months months';
//   }
// }
//
// class MyApp extends StatelessWidget {
//   final loanAmountController = TextEditingController();
//   final interestController = TextEditingController();
//   final emiController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Loan Period Calculator')),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: loanAmountController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(labelText: 'Loan Amount'),
//                 ),
//                 TextField(
//                   controller: interestController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(labelText: 'Interest Rate (%)'),
//                 ),
//                 TextField(
//                   controller: emiController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(labelText: 'EMI'),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     double loanAmount = double.parse(loanAmountController.text);
//                     double interestRate = double.parse(interestController.text);
//                     double emi = double.parse(emiController.text);
//
//                     LoanCalculator calculator =
//                     LoanCalculator(loanAmount, interestRate, emi);
//
//                     String period = calculator.calculatePeriod();
//
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text('Loan Period'),
//                           content: Text('The calculated period is: $period'),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: Text('OK'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Text('Calculate Period'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'dart:math';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Loan Calculator',
//       home: LoanCalculator(),
//     );
//   }
// }
//
// class LoanCalculator extends StatefulWidget {
//   const LoanCalculator({super.key});
//
//   @override
//   LoanCalculatorState createState() => LoanCalculatorState();
// }
//
// class LoanCalculatorState extends State<LoanCalculator> {
//   final _loanAmountController = TextEditingController();
//   final _interestRateController = TextEditingController();
//   final _emiController = TextEditingController();
//   final _periodController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Loan Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _loanAmountController,
//               decoration: const InputDecoration(
//                 labelText: 'Loan Amount',
//                 prefixIcon: Icon(Icons.attach_money),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: _interestRateController,
//               decoration: const InputDecoration(
//                 labelText: 'Interest Rate',
//                 suffixText: '%',
//                 prefixIcon: Icon(Icons.rate_review),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: _emiController,
//               decoration: const InputDecoration(
//                 labelText: 'EMI',
//                 prefixIcon: Icon(Icons.payment),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: _periodController,
//               decoration: const InputDecoration(
//                 labelText: 'Period',
//                 suffixText: 'years',
//                 prefixIcon: Icon(Icons.calendar_today),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 final loanAmount = double.parse(_loanAmountController.text);
//                 final interestRate =
//                     double.parse(_interestRateController.text) / 100;
//                 final emi = double.parse(_emiController.text);
//
//                 final p = 12; // Payment frequency per year
//                 final n = -log(1 - (interestRate / p) * loanAmount / emi) /
//                     log(1 + interestRate / p);
//                 final years = n ~/ 12;
//                 final months = (n % 12).round();
//                 _periodController.text = '$years years and $months months';
//               },
//               child: const Text('Calculate'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:math';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'EMI Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const EMIForm(),
//     );
//   }
// }
//
// class EMIForm extends StatefulWidget {
//   const EMIForm({Key? key}) : super(key: key);
//
//   @override
//   EMIFormState createState() => EMIFormState();
// }
//
// class EMIFormState extends State<EMIForm> {
//   final TextEditingController loanAmountController = TextEditingController();
//   final TextEditingController interestRateController = TextEditingController();
//   final TextEditingController emiController = TextEditingController();
//
//   double loanAmount = 0;
//   double interestRate = 0;
//   double emi = 0;
//
//   int years = 0;
//   int months = 0;
//
//   void calculateEMI() {
//     if (loanAmount <= 0 || interestRate <= 0 || emi <= 0) {
//       return;
//     }
//
//     double monthlyInterestRate = (interestRate / 12) / 100;
//     double numerator = log(emi) - log(emi - (loanAmount * monthlyInterestRate));
//     double denominator = log(1 + monthlyInterestRate);
//
//     double totalMonths = numerator / denominator;
//
//     years = (totalMonths / 12).floor();
//     months = (totalMonths % 12).floor();
//
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     loanAmountController.dispose();
//     interestRateController.dispose();
//     emiController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('EMI Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: loanAmountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Loan Amount'),
//             ),
//             TextField(
//               controller: interestRateController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Interest Rate (%)'),
//             ),
//             TextField(
//               controller: emiController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'EMI'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   loanAmount = double.tryParse(loanAmountController.text) ?? 0;
//                   interestRate =
//                       double.tryParse(interestRateController.text) ?? 0;
//                   emi = double.tryParse(emiController.text) ?? 0;
//                   calculateEMI();
//                 });
//               },
//               child: const Text('Calculate'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Years: $years, Months: $months',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'dart:math';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'EMI Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const EMIForm(),
//     );
//   }
// }
//
// class EMIForm extends StatefulWidget {
//   const EMIForm({Key? key}) : super(key: key);
//
//   @override
//   EMIFormState createState() => EMIFormState();
// }
//
// class EMIFormState extends State<EMIForm> {
//   final TextEditingController loanAmountControllerForPeriod = TextEditingController();
//   final TextEditingController interestRateControllerForPeriod = TextEditingController();
//   final TextEditingController emiControllerForPeriod = TextEditingController();
//
//   double loanAmount = 0;
//   double interestRate = 0;
//   double emi = 0;
//
//   int years = 0;
//   int months = 0;
//
//   void calculateYearsMonths() {
//     if (loanAmount <= 0 || interestRate <= 0 || emi <= 0) {
//       return;
//     }
//
//     double monthlyInterestRate = (interestRate / 12) / 100;
//     double totalMonths = (log(emi / (emi - loanAmount * monthlyInterestRate)) /
//         log(1 + monthlyInterestRate));
//
//     years = totalMonths ~/ 12;
//     months = (totalMonths % 12).round(); // Round to the nearest integer
//
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     loanAmountControllerForPeriod.dispose();
//     interestRateControllerForPeriod.dispose();
//     emiControllerForPeriod.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('EMI Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: loanAmountControllerForPeriod,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Loan Amount'),
//             ),
//             TextField(
//               controller: interestRateControllerForPeriod,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Interest Rate (%)'),
//             ),
//             TextField(
//               controller: emiControllerForPeriod,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'EMI'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   loanAmount =
//                       double.tryParse(loanAmountControllerForPeriod.text) ?? 0;
//                   interestRate =
//                       double.tryParse(interestRateControllerForPeriod.text) ?? 0;
//                   emi = double.tryParse(emiControllerForPeriod.text) ?? 0;
//                   calculateYearsMonths();
//                 });
//               },
//               child: const Text('Calculate'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Years: $years, Months: $months',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Default Number TextFormField',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DefaultNumberForm(),
    );
  }
}

class DefaultNumberForm extends StatefulWidget {
  const DefaultNumberForm({Key? key}) : super(key: key);

  @override
  _DefaultNumberFormState createState() => _DefaultNumberFormState();
}

class _DefaultNumberFormState extends State<DefaultNumberForm> {
  final TextEditingController numberController =
  TextEditingController(text: '42'); // Set your default number here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Number TextFormField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter a Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can access the entered number using numberController.text
                final enteredNumber = numberController.text;
                print('Entered Number: $enteredNumber');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    numberController.dispose(); // Dispose the controller when no longer needed
    super.dispose();
  }
}

