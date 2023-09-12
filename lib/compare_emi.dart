import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompareEMI extends StatefulWidget {
  const CompareEMI({Key? key}) : super(key: key);

  @override
  State<CompareEMI> createState() => _CompareEMIState();
}

class _CompareEMIState extends State<CompareEMI> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _loanAmountController1 = TextEditingController();
  final TextEditingController _interestRateController1 = TextEditingController();
  final TextEditingController _monthsController1 = TextEditingController();

  final TextEditingController _loanAmountController2 = TextEditingController();
  final TextEditingController _interestRateController2 = TextEditingController();
  final TextEditingController _monthsController2 = TextEditingController();



  double _emi1 = 0.0;
  double _totalInterest1 = 0.0;
  double _totalPayment1 = 0.0;

  double _emi2 = 0.0;
  double _totalInterest2 = 0.0;
  double _totalPayment2 = 0.0;


  void _calculateEMI() {
    FocusScope.of(context).unfocus();



    // loan 1 <start>
    double loanAmount1 = double.tryParse(_loanAmountController1.text.replaceAll(',', '')) ?? 0.0 ;
    double interestRate1 = double.tryParse(_interestRateController1.text.replaceAll(',', '')) ?? 0.0;
    int month1 = int.tryParse(_monthsController1.text) ?? 0;

    int totalMonths =  month1 ;
    double monthlyInterestRate = interestRate1 / 1200; // Dividing by 1200 to convert percentage to decimal

    double emi = (loanAmount1 * monthlyInterestRate * pow(1 + monthlyInterestRate, totalMonths)) /
        (pow(1 + monthlyInterestRate, totalMonths) - 1);

    double totalPayment = emi * totalMonths;
    double totalInterest = totalPayment - loanAmount1;
    // loan 1 <end>

    // loan 2 <start>
    double loanAmount2 = double.tryParse(_loanAmountController2.text.replaceAll(',', '')) ?? 0.0 ;
    double interestRate2 = double.tryParse(_interestRateController2.text.replaceAll(',', '')) ?? 0.0;
    int month2 = int.tryParse(_monthsController2.text) ?? 0;

    int totalMonths2 =  month2 ;
    double monthlyInterestRate2 = interestRate2 / 1200; // Dividing by 1200 to convert percentage to decimal

    double emi2 = (loanAmount2 * monthlyInterestRate2 * pow(1 + monthlyInterestRate2, totalMonths2)) /
        (pow(1 + monthlyInterestRate2, totalMonths2) - 1);

    double totalPayment2 = emi2 * totalMonths2;
    double totalInterest2 = totalPayment2 - loanAmount2;
    // loan 2 <end>

    if(loanAmount1 <= 0 || loanAmount2 <= 0){
      _showSnackbar('Please Enter Proper Amount');
      return;
    }else if(interestRate1 <= 0 || interestRate2 <= 0){
      _showSnackbar('Please Enter Proper Interest');
      return;
    }else if(month1 <= 0 || month2 <= 0){
      _showSnackbar('Please Enter Proper Period');
      return;
    }


    setState(() {
      _emi1 = emi;
      _totalInterest1 = totalInterest;
      _totalPayment1 = totalPayment;

      _emi2 = emi2;
      _totalInterest2 = totalInterest2;
      _totalPayment2 = totalPayment2;

    });

  }

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
        title: const Text('Compare EMI',style: TextStyle(color: Colors.white,fontSize: 27.0,fontWeight: FontWeight.bold),),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: ListView(
              children: [
                const SizedBox(height: 20),
                 Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: const Center(child: Text('Loan 1',style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 18.0),)),
                        ),
                      ),
                      const SizedBox(width: 20.0,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: const Center(child: Text('Loan 2',style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 18.0),)),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 30.0,),
                const Expanded(child: Center(child: Text('Principal Amount',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w500)))),
                const SizedBox(height: 10.0,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _loanAmountController1,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          // labelText: 'Interest Rate',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
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
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _loanAmountController2,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          // labelText: 'Interest Rate',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
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
                const SizedBox(height: 25.0,),
                const Expanded(child: Center(child: Text('Interest',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w500)))),
                const SizedBox(height: 10.0,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _interestRateController1,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          // labelText: 'Interest Rate',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
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
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _interestRateController2,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          // labelText: 'Interest Rate',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
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
                const SizedBox(height: 25.0,),
                const Expanded(child: Center(child: Text('Period (Month)',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w500)))),
                const SizedBox(height: 10.0,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _monthsController1,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          // labelText: 'Interest Rate',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
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
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _monthsController2,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          // labelText: 'Interest Rate',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
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
                const SizedBox(height: 20.0,),
                Center(
                  child: ElevatedButton(
                    onPressed: _calculateEMI,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    child: const Text('CALCULATE', style: TextStyle(fontSize: 16.0)),
                  ),
                ),

                Column(
                  children: [
                    const SizedBox(height: 20.0),
                    const Center(
                      child: Text(
                        'Monthly EMI',
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text('₹ ${_emi1.toStringAsFixed(2)}',style: const TextStyle(fontSize: 18),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('₹ ${_emi2.toStringAsFixed(2)}',style: const TextStyle(fontSize: 18),),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'Difference: ₹ ${(_emi1 - _emi2).abs().toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Divider(thickness: 2),
                    const SizedBox(height: 20.0),
                    const Center(
                      child: Text(
                        'Total Interest',
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text('₹ ${_totalInterest1.toStringAsFixed(2)}',style: const TextStyle(fontSize: 18),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('₹ ${_totalInterest2.toStringAsFixed(2)}',style: const TextStyle(fontSize: 18),),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'Difference: ₹ ${(_totalInterest1 - _totalInterest2).abs().toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Divider(thickness: 2),
                    const SizedBox(height: 20.0),
                    const Center(
                      child: Text(
                        'Total Payment',
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text('₹ ${_totalPayment1.toStringAsFixed(2)}',style: const TextStyle(fontSize: 18),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('₹ ${_totalPayment2.toStringAsFixed(2)}',style: const TextStyle(fontSize: 18),),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'Difference: ₹ ${(_totalPayment1 - _totalPayment2).abs().toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Divider(thickness: 2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
