//
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
// class DetailScreen extends StatelessWidget {
//   final String loanAmount;
//   final String interestRate;
//   final int totalMonths;
//   final double emi;
//   final double totalInterest;
//   final double totalPayment;
//   final List<Map<String, String>> tableData;
//
//   const DetailScreen({
//     Key? key,
//     required this.loanAmount,
//     required this.interestRate,
//     required this.totalMonths,
//     required this.emi,
//     required this.totalInterest,
//     required this.totalPayment,
//     required this.tableData,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurpleAccent,
//         title: SizedBox(width: 250,child: Center(child: const Text('EMI Details'))),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 50,),
//             Container(color: Colors.deepPurpleAccent,
//               width: MediaQuery.of(context).size.width,
//               height: 34,
//               child: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Text('EMI Details',style: TextStyle(color: Colors.white,fontSize: 18),),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: Column(
//                 children: [
//                 SizedBox(
//                   height: 30,
//                   child: ListTile(
//                     title: Text('loanAmount'),
//                     trailing: Text(loanAmount),
//                   ),
//                 ),
//                   SizedBox(
//                     height: 30,
//                     child: ListTile(
//                       title: Text('Interest %'),
//                       trailing: Text(interestRate),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                     child: ListTile(
//                       title: Text('Periods(Month)'),
//                       trailing: Text('$totalMonths Months'),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                     child: ListTile(
//                       title: Text('Monthly EMI'),
//                       trailing: Text('₹ ${emi.toStringAsFixed(2)}'),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                     child: ListTile(
//                       title: Text('Total Interest'),
//                       trailing: Text('₹ ${totalInterest.toStringAsFixed(2)}'),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 35,
//                     child: ListTile(
//                       title: Text('Total Payment'),
//                       trailing: Text('₹ ${totalPayment.toStringAsFixed(2)}'),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//             SizedBox(height: 30,),
//             SizedBox(
//               height: 500,
//               child: AnimationLimiter(
//                 child: ListView.builder(
//                   itemCount: tableData.length,
//                   itemBuilder: (context, index) {
//                     final data = tableData[index];
//                     int monthNumber = int.parse(data['Month']!);
//                     bool isEvenMonth = monthNumber % 2 == 0;
//
//                     return AnimationConfiguration.staggeredList(
//                       position: index,
//                       duration: const Duration(milliseconds: 375),
//                       child: SlideAnimation(
//                         verticalOffset: 50.0,
//                         child: FadeInAnimation(
//                           child: Card(
//                             color:
//                             isEvenMonth ? Colors.
//                             // grey.withOpacity(0.5)
//                             white
//                                 : Colors.white,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//
//                                     child: Text(data['Month']!),
//                                   ),
//                                   Expanded(
//
//                                     child: Text(data['Principal']!),
//                                   ),
//                                   Expanded(
//
//                                     child: Text(data['Interest']!),
//                                   ),
//                                   Expanded(
//
//                                     child: Text(data['Balance']!),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

// import 'package:pie_chart/pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class DetailScreen extends StatefulWidget {
  final String loanAmount;
  final String interestRate;
  final int totalMonths;
  final double emi;
  final double totalInterest;
  final double totalPayment;
  final List<Map<String, String>> tableData;

  const DetailScreen({
    Key? key,
    required this.loanAmount,
    required this.interestRate,
    required this.totalMonths,
    required this.emi,
    required this.totalInterest,
    required this.totalPayment,
    required this.tableData,
  }) : super(key: key);

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const SizedBox(width: 250, child: Center(child: Text('EMI Details'))),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(40.0),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         _buildSegmentedControl('Details', 0),
        //         SizedBox(width: 20),
        //         _buildSegmentedControl('Chart', 1),
        //       ],
        //     ),
        //   ),
        // ),

      ),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSegmentedControl('Details', 0),
                // SizedBox(width: 20),
                _buildSegmentedControl('Chart', 1),
              ],
            ),
          ),
         SingleChildScrollView(
          child: _selectedIndex == 0
              ? _buildDetails()
              : _buildChart(),
        ),
    ],
      ),
    );
  }

  Widget _buildSegmentedControl(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.deepPurpleAccent : Colors.transparent,
          // borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _selectedIndex == index ? Colors.deepPurpleAccent : Colors.deepPurpleAccent, // Outline border color
            width: 2.0, // Border width
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.deepPurpleAccent,
            width: MediaQuery.of(context).size.width,
            height: 34,
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'EMI Details',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Loan Amount', widget.loanAmount),
                _buildDetailRow('Interest Rate', widget.interestRate),
                _buildDetailRow('Total Months', '${widget.totalMonths} Months'),
                _buildDetailRow('Monthly EMI', '₹ ${widget.emi.toStringAsFixed(2)}'),
                _buildDetailRow('Total Interest', '₹ ${widget.totalInterest.toStringAsFixed(2)}'),
                _buildDetailRow('Total Payment', '₹ ${widget.totalPayment.toStringAsFixed(2)}'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AnimationLimiter(
            child: ListView.builder(
              itemCount: widget.tableData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = widget.tableData[index];
                int monthNumber = int.parse(data['Month']!);
                bool isEvenMonth = monthNumber % 2 == 0;

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Card(
                        color: isEvenMonth ? Colors.white : Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.deepPurpleAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Center(
                                child: Text(
                                  'Month ${data['Month']}',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildCardContentRow('Principal', data['Principal']!),
                                  _buildCardContentRow('Interest', data['Interest']!),
                                  _buildCardContentRow('Balance', data['Balance']!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
    );
  }

  Widget _buildChart() {
    // Calculation
    double interestPercentage = (widget.totalInterest / widget.totalPayment) * 100;
    double principalPercentage = 100 - interestPercentage;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: principalPercentage,
                    color: Colors.deepOrangeAccent.shade200,
                    title: '${principalPercentage.toStringAsFixed(1)}%',
                    radius: 70,
                    titleStyle: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  PieChartSectionData(
                    value: interestPercentage,
                    color: Colors.blue.shade400,
                    title: '${interestPercentage.toStringAsFixed(1)}%',
                    radius: 70,
                    titleStyle: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
                centerSpaceRadius: 50,
                sectionsSpace: 0,
              ),
              swapAnimationDuration: const Duration(milliseconds: 20000),
              swapAnimationCurve: Curves.linear,
            ),
          ),
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration:  BoxDecoration(
                          color: Colors.blue.shade400,
                          shape: BoxShape.circle,
                        ),
                      ),
                  const SizedBox(width: 5),
                   Text('Interest            ${interestPercentage.toStringAsFixed(1)}%', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration:  BoxDecoration(
                          color: Colors.deepOrangeAccent.shade200,
                          shape: BoxShape.circle,
                        ),
                      ),

                  const SizedBox(width: 5),
                   Text('Principal          ${principalPercentage.toStringAsFixed(1)}%', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // const SizedBox(height: 20,),
        ],
      ),
    );
  }


  // Widget _buildChart() {
  //   // Calculation
  //   double interestPercentage = (widget.totalInterest / widget.totalPayment) * 100;
  //   double principalPercentage = 100 - interestPercentage;
  //
  //   late int touchedIndex;
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       children: [
  //         AspectRatio(
  //           aspectRatio: 1,
  //           child: PieChart(
  //             PieChartData(
  //               sections: [
  //                 PieChartSectionData(
  //                   value: principalPercentage,
  //                   color: Colors.blue,
  //                   title: '${principalPercentage.toStringAsFixed(1)}%',
  //                   radius: 100,
  //                   titleStyle: TextStyle(fontSize: 18, color: Colors.white),
  //                 ),
  //                 PieChartSectionData(
  //                   value: interestPercentage,
  //                   color: Colors.red,
  //                   title: '${interestPercentage.toStringAsFixed(1)}%',
  //                   radius: 100,
  //                   titleStyle: TextStyle(fontSize: 18, color: Colors.white),
  //                 ),
  //               ],
  //               centerSpaceRadius: 0,
  //               sectionsSpace: 2,
  //               startDegreeOffset: -90,
  //               borderData: FlBorderData(show: false),
  //               pieTouchData: PieTouchData(
  //                 touchCallback: (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
  //                   if (pieTouchResponse == null || event is PointerUpEvent) {
  //                     // Hide the tooltip
  //                     setState(() {
  //                       touchedIndex = -1;
  //                     });
  //                   } else {
  //                     // Show the tooltip
  //                     setState(() {
  //                       touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
  //                     });
  //                   }
  //                 },
  //               ),
  //
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //               width: 15,
  //               height: 15,
  //               decoration: BoxDecoration(
  //                 color: Colors.red,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //             const SizedBox(width: 5),
  //             const Text('Interest', style: TextStyle(fontSize: 15)),
  //             const SizedBox(width: 20),
  //             Container(
  //               width: 15,
  //               height: 15,
  //               decoration: BoxDecoration(
  //                 color: Colors.blue,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //             const SizedBox(width: 5),
  //             const Text('Principal', style: TextStyle(fontSize: 15)),
  //           ],
  //         ),
  //         const SizedBox(height: 20,),
  //         touchedIndex != -1 ? Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(5),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.5),
  //                 spreadRadius: 1,
  //                 blurRadius: 5,
  //                 offset: const Offset(0, 3),
  //               ),
  //             ],
  //           ),
  //           padding: const EdgeInsets.all(10),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Interest: ${interestPercentage.toStringAsFixed(1)}%'),
  //               Text('Principal: ${principalPercentage.toStringAsFixed(1)}%'),
  //             ],
  //           ),
  //         ) : Container(),
  //       ],
  //     ),
  //   );
  // }


  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildCardContentRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

