import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sewa_motor/Services/transaction_service.dart';
import 'package:sewa_motor/components/my_text.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;
  final String status;
  final String docId;
  CountdownTimer({
    required this.endTime,
    required this.status,
    required this.docId,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  late Duration _duration;
  TransactionService transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _duration = widget.endTime.difference(DateTime.now());
    if (widget.status == 'Ongoing') {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final remainingTime = widget.endTime.difference(DateTime.now());
      if (remainingTime.isNegative) {
        _timer?.cancel();
        transactionService.countdownUpdate(widget.docId, Timestamp.now());
      } else {
        setState(() {
          _duration = remainingTime;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));
    return Row(
      children: [
        Container(
          width: 80,
          height: 70,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: MyText(
              text: hours,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: 80,
          height: 70,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: MyText(
              text: minutes,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: 80,
          height: 70,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: MyText(
              text: seconds,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
