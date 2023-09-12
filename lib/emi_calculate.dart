import 'dart:math';
import 'Detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class EMICalculatorScreen extends StatefulWidget {
  const EMICalculatorScreen({super.key});

  @override
  EMICalculatorScreenState createState() => EMICalculatorScreenState();
}

class EMICalculatorScreenState extends State<EMICalculatorScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Find EMi <start>
  final List<Map<String, String>> tableData = [];
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  final TextEditingController monthsController = TextEditingController();
  double emi0 = 0.0;
  double totalInterest0 = 0.0;
  double totalPayment0 = 0.0;
  int totalMonths0 = 0;

  void calculateEMI() {
    FocusScope.of(context).unfocus();

    double loanAmount = double.tryParse(
        loanAmountController.text.replaceAll(',', '')) ?? 0.0;
    double interestRate = double.tryParse(
        interestRateController.text.replaceAll(',', '')) ?? 0.0;
    int years = int.tryParse(yearsController.text) ?? 0;
    int months = int.tryParse(monthsController.text) ?? 0;


    // if (loanAmount <= 0 || interestRate <= 0 || (years <= 0 && months <= 0)) {
    //   _showSnackbar('Please enter valid loan details');
    //   return;
    // }

    if (loanAmount <= 0) {
      _showSnackbar('Please Enter Proper Amount');
      return;
    } else if (interestRate <= 0) {
      _showSnackbar('Please Enter Proper Interest');
      return;
    } else if (years <= 0 && months <= 0) {
      _showSnackbar('Please Enter  Proper Period');
      return;
    }

    int totalMonths = (years * 12) + months;
    double monthlyInterestRate = interestRate /
        1200; // Dividing by 1200 to convert percentage to decimal

    double emi = (loanAmount * monthlyInterestRate *
        pow(1 + monthlyInterestRate, totalMonths)) /
        (pow(1 + monthlyInterestRate, totalMonths) - 1);

    double totalPayment = emi * totalMonths;
    double totalInterest = totalPayment - loanAmount;

    setState(() {
      emi0 = emi;
      totalInterest0 = totalInterest;
      totalPayment0 = totalPayment;


      totalMonths0 = totalMonths;


      tableData.clear();
      double balance = loanAmount;
      for (int i = 1; i <= totalMonths; i++) {
        double interest = balance * monthlyInterestRate;
        double principal = emi - interest;
        balance -= principal;
        tableData.add({
          'Month': i.toString(),
          'Interest': '₹${interest.toStringAsFixed(2)}',
          'Principal': '₹${principal.toStringAsFixed(2)}',
          'Balance': '₹${balance.toStringAsFixed(2)}',
        });
      }
    });
  }


  void reset() {
    loanAmountController.clear();
    interestRateController.clear();
    yearsController.clear();
    monthsController.clear();

    setState(() {
      emi0 = 0.0;
      totalInterest0 = 0.0;
      totalPayment0 = 0.0;


      tableData.clear();
    });
  }


  void showDetailScreen() {
    if (tableData.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailScreen(
                emi: emi0,
                totalInterest: totalInterest0,
                totalPayment: totalPayment0,
                tableData: tableData,
                loanAmount: loanAmountController.text,
                interestRate: interestRateController.text,
                totalMonths: totalMonths0,
              ),
        ),
      );
    }
  }

// Find EMi <end>

  // Find Amount <start>
  TextEditingController emiControllerForAmount = TextEditingController();
  TextEditingController interestRateControllerForAmount = TextEditingController();

  // TextEditingController tenureControllerForAmount = TextEditingController();
  TextEditingController yearsControllerForAmount = TextEditingController();
  TextEditingController monthsControllerForAmount = TextEditingController();

  double principal0 = 0.0;

  void calculatePrincipal() {
    FocusScope.of(context).unfocus();
    double emi = double.tryParse(emiControllerForAmount.text) ?? 0.0;
    double interestRate = double.tryParse(
        interestRateControllerForAmount.text) ?? 0.0;
    // int tenureInMonths = int.tryParse(tenureControllerForAmount.text) ?? 0;
    int years = int.tryParse(yearsControllerForAmount.text) ?? 0;
    int months = int.tryParse(monthsControllerForAmount.text) ?? 0;

    // if (emi <= 0 || interestRate <= 0 || tenureInMonths <= 0) {
    //   return; // Invalid input, do not calculate
    // }
    if (emi <= 0) {
      _showSnackbar('Please Enter Proper EMI');
    } else if (interestRate <= 0) {
      _showSnackbar('Please Enter Proper Interest');
    } else if (years <= 0 && months <= 0) {
      _showSnackbar('Please Enter Proper Period');
    }

    int tenureInMonths = (years * 12) +
        months; // Calculate total tenure in months

    double monthlyInterestRate = interestRate /
        1200; // Convert percentage to decimal
    double principal = (emi *
        (1 - (1 / pow(1 + monthlyInterestRate, tenureInMonths)))) /
        monthlyInterestRate;

    // Round the principal amount to two decimal places
    principal = double.parse(principal.toStringAsFixed(2));

    setState(() {
      principal0 = principal;
    });
  }

  void reset2() {
    emiControllerForAmount.clear();
    interestRateControllerForAmount.clear();
    yearsControllerForAmount.clear();
    monthsControllerForAmount.clear();

    setState(() {
      principal0 = 0.0;
    });
  }

  // Find Amount <end>

  // Find Interest <start>
  TextEditingController emiControllerForInterest = TextEditingController();
  TextEditingController principalControllerForInterest = TextEditingController();

  // TextEditingController tenureControllerForInterest = TextEditingController();
  TextEditingController yearsControllerForInterest = TextEditingController();
  TextEditingController monthsControllerForInterest = TextEditingController();

  double interestRate0 = 0.0;


  void calculateInterestRate() {
    double emi = double.tryParse(emiControllerForInterest.text) ?? 0.0;
    double principal = double.tryParse(principalControllerForInterest.text) ??
        0.0;
    // int tenureInMonths = int.tryParse(tenureControllerForInterest.text) ?? 0;
    int years = int.tryParse(yearsControllerForInterest.text) ?? 0;
    int months = int.tryParse(monthsControllerForInterest.text) ?? 0;

    // if (emi <= 0 || principal <= 0 || tenureInMonths <= 0) {
    //   return; // Invalid input, do not calculate
    // }

    int tenureInMonths = (years * 12) + months;
    // double interestRate = ((emi * tenureInMonths) / principal - 1) * 1200;
    // R = [(1 + EMI/P)^N - 1] / (N * EMI)
    // double interestRate = (1 + emi / principal) ^ years - 1;
    // interestRate = interestRate / (years * emi);
    // double emi = (loanAmount * monthlyInterestRate *
    //     pow(1 + monthlyInterestRate, totalMonths)) /
    //     (pow(1 + monthlyInterestRate, totalMonths) - 1);
    // R = (EMI/P) * (12/n) * 100
    // double interestRate = (emi / principal) * (12/tenureInMonths) * 100;
    // R = ((EMI * n) - P) / (P * n/12) * 100
    // double interestRate = ((emi * tenureInMonths) - principal) / (principal * tenureInMonths/12) * 100;
    // R = ((EMI x Total Months) / Loan Amount) - 1
    // double interestRate = ((emi * tenureInMonths) / principal) -1;
    // double interestRate = pow((emi * tenureInMonths / principal), (1 / tenureInMonths)) - 1;
    // R = (EMI * n * 100) / P
    // double interestRate = (emi * tenureInMonths * 100) / principal;
    // double interestRate = ((emi * tenureInMonths) / principal - 1) / tenureInMonths;
    // double monthlyInterestRate = (emi / principal) / ((pow(1 + (emi / principal), -tenureInMonths)) - 1);
    // double monthlyInterestRate = (emi * tenureInMonths - principal) / (principal * tenureInMonths);
    // double annualInterestRate = monthlyInterestRate * 12 * 100;
    // R = [EMI x (1+R)^N - P] / [P x (1+R)^N-1]
    // R = [(EMI x N) - P] / [P x (N + 1) / 2] x 1200
    double interestRate = ((emi * tenureInMonths) - principal) / (principal * (tenureInMonths + 1) / 2) * 1200;
    // print('EMI: $emi');
    // print('Principal: $principal');
    // print('Tenure in Months: $tenureInMonths');
    // print('Interest Rate: $interestRate');


    setState(() {
      interestRate0 = interestRate;

    });
  }
  void reset3() {
    emiControllerForInterest.clear();
    principalControllerForInterest.clear();
    yearsControllerForInterest.clear();
    monthsControllerForInterest.clear();
    setState(() {
      interestRate0 = 0.0;
    });
  }
  // Find Interest <end>

  // Find Period <start>
  final TextEditingController loanAmountControllerForPeriod = TextEditingController();
  final TextEditingController interestRateControllerForPeriod = TextEditingController();
  final TextEditingController emiControllerForPeriod = TextEditingController();

  double loanAmount = 0;
  double interestRate = 0;
  double emi = 0;

  int years = 0;
  int months = 0;

  void calculateYearsMonths() {
    if (loanAmount <= 0 || interestRate <= 0 || emi <= 0) {
      return;
    }

    double monthlyInterestRate = (interestRate / 12) / 100;
    double totalMonths = (log(
        emi / (emi - loanAmount * monthlyInterestRate)) /
        log(1 + monthlyInterestRate));

    years = totalMonths ~/ 12;
    months = (totalMonths % 12).round(); // Round to the nearest integer

    setState(() {});
  }

  @override
  void dispose() {
    loanAmountControllerForPeriod.dispose();
    interestRateControllerForPeriod.dispose();
    emiControllerForPeriod.dispose();
    super.dispose();
  }
  void reset4() {
    loanAmountControllerForPeriod.clear();
    interestRateControllerForPeriod.clear();
    emiControllerForPeriod.clear();
    setState(() {
      emi = 0.0;
    });
  }

// Find Period <end>

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'EMI Calculator',
          style: TextStyle(
              color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSegmentedControl('EMI', 0),
                _buildSegmentedControl('Loan Amount', 1),
                _buildSegmentedControl('Interest', 2),
                _buildSegmentedControl('Period', 3),
              ],
            ),
          ),
          _selectedIndex == 0
              ? _buildEMI()
              : _selectedIndex == 1
              ? _buildAmount()
              : _selectedIndex == 2
              ?_buildInterest()
              : _buildPeriod()
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(String title, int index) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedIndex == index ? Colors.deepPurpleAccent : Colors
                    .transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _selectedIndex == index
                      ? Colors.deepPurpleAccent
                      : Colors.deepPurpleAccent, // Outline border color
                  width: 2.0, // Border width
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _selectedIndex == index ? Colors.white : Colors
                          .black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
        ],
    );
  }

  Widget _buildEMI() {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Loan Amount', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: loanAmountController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Loan Amount',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0), // Border side
                        borderRadius: BorderRadius.circular(
                            20.0), // Border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),

            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Interest %', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: interestRateController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Interest Rate',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Period', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                // const SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: yearsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      hintText: 'Years',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: monthsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      hintText: 'Months',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculateEMI,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'CALCULATE',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: reset,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'RESET', style: TextStyle(fontSize: 12.0),),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: showDetailScreen,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.deepPurpleAccent,
                      backgroundColor: emi0 > 0
                          ? Colors.deepPurpleAccent
                          : Colors.grey,
                      // onPrimary: Colors.white, // Set the text color
                      elevation: emi0 > 0 ? 8.0 : 0.0,
                      minimumSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Text(
                        'DETAILS', style: TextStyle(fontSize: 12.0)),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20.0),
            Column(
              children: [
                emi0 > 0
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Container(
                        color: Colors.grey,
                        height: 275,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: const Text('Monthly EMI'),
                                  trailing: Text(
                                      '₹ ${emi0.toStringAsFixed(2)}'),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: const Text('Periods(Month)'),
                                  trailing: Text('$totalMonths0 Months'),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: const Text('Total Interest'),
                                  trailing: Text(
                                      '₹ ${totalInterest0.toStringAsFixed(2)}'),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: const Text('Total Payment'),
                                  trailing: Text(
                                      '₹ ${totalPayment0.toStringAsFixed(2)}'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Container(),
              ],
            ),

          ],
        ),
      ),
    );
  }


  Widget _buildAmount() {
    // return Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       TextFormField(
    //         controller: emiControllerForAmount,
    //         keyboardType: TextInputType.number,
    //         decoration: const InputDecoration(labelText: 'EMI'),
    //       ),
    //       const SizedBox(height: 20.0,),
    //       TextFormField(
    //         controller: interestRateControllerForAmount,
    //         keyboardType: TextInputType.number,
    //         decoration: const InputDecoration(
    //             labelText: 'Interest Rate (%)',
    //           // filled: true,
    //           // fillColor: Colors.grey,
    //           // contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    //           // border: OutlineInputBorder(
    //           //   borderRadius: BorderRadius.only(
    //           //     topLeft: Radius.circular(20.0),
    //           //     bottomRight: Radius.circular(20.0),
    //           //   ),
    //           //   borderSide: BorderSide.none, // Remove the default border
    //           // ),
    //         ),
    //       ),
    //       Row(
    //         children: [
    //           Expanded(
    //             flex: 1,
    //             child: TextFormField(
    //               controller: yearsControllerForAmount,
    //               keyboardType: TextInputType.number,
    //               decoration: const InputDecoration(labelText: 'Loan Tenure (Months)'),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 1,
    //             child: TextFormField(
    //               controller: monthsControllerForAmount,
    //               keyboardType: TextInputType.number,
    //               decoration: const InputDecoration(labelText: 'Loan Tenure (Months)'),
    //             ),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: 20),
    //       ElevatedButton(
    //         onPressed: calculatePrincipal,
    //         child: const Text('Calculate Principal'),
    //       ),
    //       const SizedBox(height: 20),
    //       principal0 > 0
    //           ? Text(
    //         'Principal Amount: ₹${principal0.toStringAsFixed(2)}',
    //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       )
    //           : Container(),
    //     ],
    //   ),
    // );
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('EMI', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: emiControllerForAmount,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Loan Amount',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0), // Border side
                        borderRadius: BorderRadius.circular(
                            20.0), // Border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),

            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Interest %', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: interestRateControllerForAmount,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Interest Rate',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Period', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                // const SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: yearsControllerForAmount,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      hintText: 'Years',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: monthsControllerForAmount,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      hintText: 'Months',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculatePrincipal,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'CALCULATE',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: reset2,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'RESET', style: TextStyle(fontSize: 12.0),),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: showDetailScreen,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.deepPurpleAccent,
                      backgroundColor: emi0 > 0
                          ? Colors.deepPurpleAccent
                          : Colors.grey,
                      // onPrimary: Colors.white, // Set the text color
                      elevation: emi0 > 0 ? 8.0 : 0.0,
                      minimumSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Text(
                        'DETAILS', style: TextStyle(fontSize: 12.0)),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20.0),
            Column(
              children: [
                const SizedBox(height: 20),
                principal0 > 0
                    ? Text(
                  'Principal Amount: ₹${principal0.toStringAsFixed(1)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )
                    : Container(),
              ],
            ),

          ],
        ),
      ),
    );
  }


  Widget _buildInterest() {
    //   return Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         TextFormField(
    //           controller: emiControllerForInterest,
    //           keyboardType: TextInputType.number,
    //           decoration: const InputDecoration(labelText: 'EMI'),
    //         ),
    //         TextFormField(
    //           controller: principalControllerForInterest,
    //           keyboardType: TextInputType.number,
    //           decoration: const InputDecoration(labelText: 'Principal Amount'),
    //         ),
    //         Row(
    //           children: [
    //             Expanded(
    //               flex: 1,
    //               child: TextFormField(
    //                 controller: yearsControllerForInterest,
    //                 keyboardType: TextInputType.number,
    //                 decoration: const InputDecoration(labelText: 'Loan Tenure (year)'),
    //               ),
    //             ),
    //             Expanded(
    //               flex: 1,
    //               child: TextFormField(
    //                 controller: monthsControllerForInterest,
    //                 keyboardType: TextInputType.number,
    //                 decoration: const InputDecoration(labelText: 'Loan Tenure (Month)'),
    //               ),
    //             ),
    //           ],
    //         ),
    //         const SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: calculateInterestRate,
    //           child: const Text('Calculate Interest Rate'),
    //         ),
    //         const SizedBox(height: 20),
    //         interestRate0 > 0
    //             ? Text(
    //           'Interest Rate: ${interestRate0.toStringAsFixed(2)}%',
    //           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         )
    //             : Container(),
    //       ],
    //     ),
    //   );
    //
    // }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('EMI', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: emiControllerForInterest,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Loan Amount',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0), // Border side
                        borderRadius: BorderRadius.circular(
                            20.0), // Border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),

            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Loan Amount', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: principalControllerForInterest,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Interest Rate',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Period', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                // const SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: yearsControllerForInterest,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      hintText: 'Years',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: monthsControllerForInterest,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      hintText: 'Months',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculateInterestRate,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'CALCULATE',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: reset3,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'RESET', style: TextStyle(fontSize: 12.0),),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: showDetailScreen,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.deepPurpleAccent,
                      backgroundColor: emi0 > 0
                          ? Colors.deepPurpleAccent
                          : Colors.grey,
                      // onPrimary: Colors.white, // Set the text color
                      elevation: emi0 > 0 ? 8.0 : 0.0,
                      minimumSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Text(
                        'DETAILS', style: TextStyle(fontSize: 12.0)),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20.0),
            Column(
              children: [
                const SizedBox(height: 20),
                interestRate0 > 0
                            ? Column(
                              children: [
                                Text(
                          'Interest Rate: ${interestRate0.toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                                // Text(
                                //   'Interest Rate: ${interestRateYear.toStringAsFixed(2)}%',
                                //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                // ),
                              ],
                            )
                            : Container(),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildPeriod() {

    // return Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       TextField(
    //         controller: loanAmountControllerForPeriod,
    //         keyboardType: TextInputType.number,
    //         decoration: const InputDecoration(labelText: 'Loan Amount'),
    //       ),
    //       TextField(
    //         controller: interestRateControllerForPeriod,
    //         keyboardType: TextInputType.number,
    //         decoration: const InputDecoration(labelText: 'Interest Rate (%)'),
    //       ),
    //       TextField(
    //         controller: emiControllerForPeriod,
    //         keyboardType: TextInputType.number,
    //         decoration: const InputDecoration(labelText: 'EMI'),
    //       ),
    //       const SizedBox(height: 20),
    //       ElevatedButton(
    //         onPressed: () {
    //           setState(() {
    //             loanAmount =
    //                 double.tryParse(loanAmountControllerForPeriod.text) ?? 0;
    //             interestRate =
    //                 double.tryParse(interestRateControllerForPeriod.text) ?? 0;
    //             emi = double.tryParse(emiControllerForPeriod.text) ?? 0;
    //             calculateYearsMonths();
    //           });
    //         },
    //         child: const Text('Calculate'),
    //       ),
    //       const SizedBox(height: 20),
    //       Text(
    //         'Years: $years, Months: $months',
    //         style: const TextStyle(fontSize: 18),
    //       ),
    //     ],
    //   ),
    //
    // );

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Loan Amount', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: loanAmountControllerForPeriod,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Loan Amount',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0), // Border side
                        borderRadius: BorderRadius.circular(
                            20.0), // Border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),

            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Interest Rate', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: interestRateControllerForPeriod,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      // labelText: 'Interest Rate',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
                Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text('EMI', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),),
                    ),
                // const SizedBox(width: 10.0),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: emiControllerForPeriod,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                  ],
                ),

            const SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
            onPressed: () {
                  setState(() {
                    loanAmount =
                        double.tryParse(loanAmountControllerForPeriod.text) ?? 0;
                    interestRate =
                        double.tryParse(interestRateControllerForPeriod.text) ?? 0;
                    emi = double.tryParse(emiControllerForPeriod.text) ?? 0;
                    calculateYearsMonths();
                  });
                },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'CALCULATE',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: reset4,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(0, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text(
                      'RESET', style: TextStyle(fontSize: 12.0),),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: showDetailScreen,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.deepPurpleAccent,
                      backgroundColor: emi0 > 0
                          ? Colors.deepPurpleAccent
                          : Colors.grey,
                      // onPrimary: Colors.white, // Set the text color
                      elevation: emi0 > 0 ? 8.0 : 0.0,
                      minimumSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Text(
                        'DETAILS', style: TextStyle(fontSize: 12.0)),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20.0),
            Column(
              children: [
                const SizedBox(height: 20),
                emi > 0
                    ? Column(
                  children: [
                    Text(
                              'Years: $years, Months: $months',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                  ],
                )
                    : Container(),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
