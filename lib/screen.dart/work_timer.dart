import 'package:flutter/material.dart';
import 'package:thesovereigndiary/model/timer.dart';
import '../model/counter_timer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../widgets/productivity_button.dart';

class WorkTimer extends StatefulWidget {
  @override
  _WorkTimerState createState() => _WorkTimerState();
}

class _WorkTimerState extends State<WorkTimer> {
  final EdgeInsets padding = EdgeInsets.all(5.0);

  void emptyMethod() {}
  @override
  Widget build(BuildContext context) {
    final CounterTimer timer = CounterTimer();
    final buttonWidth = MediaQuery.of(context).size.width - 30;
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text("Work Timer"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: padding,
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: "Work",
                      size: buttonWidth / 3,
                      onPressed: timer.startWork,
                    ),
                  ),
                  Padding(
                    padding: padding,
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: "Short Break",
                      size: buttonWidth / 3,
                      onPressed: () => timer.startBreak(true),
                    ),
                  ),
                  Padding(
                    padding: padding,
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff455A64),
                      text: "Long Break",
                      size: buttonWidth / 3,
                      onPressed: () => timer.startBreak(false),
                    ),
                  ),
                  Padding(
                    padding: padding,
                  ),
                ],
              ),
              StreamBuilder(
                  initialData: "00:00",
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Timer timer = (snapshot.data == '00:00')
                        ? Timer("00:00", 1)
                        : snapshot.data;
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 10.0,
                        percent: timer.percent,
                        center: Text(
                          timer.time,
                        ),
                        progressColor: Color(0xff009688),
                      ),
                    );
                  }),
              Row(
                children: <Widget>[
                  Padding(
                    padding: padding,
                  ),
                  ProductivityButton(
                    color: Color(0xff212121),
                    text: 'Stop',
                    size: buttonWidth / 2,
                    onPressed: timer.stopTimer,
                  ),
                  Padding(
                    padding: padding,
                  ),
                  ProductivityButton(
                    color: Color(0xff009688),
                    text: 'Restart',
                    size: buttonWidth / 2,
                    onPressed: timer.startTimer,
                  ),
                  Padding(
                    padding: padding,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
