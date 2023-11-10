import 'package:flutter/material.dart';

class AdminCheckIn extends StatefulWidget {
  const AdminCheckIn({super.key});

  @override
  State<AdminCheckIn> createState() => _AdminCheckInState();
}

class _AdminCheckInState extends State<AdminCheckIn> {
  //array of history either checkin or checkout with the date and time
  int isCheckIn = 0;
  List<Map<String, String>> history = [
    {
      "nama": "Abdul",
      "date": "12/12/2021",
      "time": "12:00",
      "status": "checkin"
    },
    {
      "nama": "Kevin",
      "date": "12/12/2021",
      "time": "13:00",
      "status": "checkin"
    },
    {
      "nama": "Abdul",
      "date": "12/12/2021",
      "time": "18:00",
      "status": "checkout"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
              "Member Latihan",
              style: TextStyle(
                  fontSize: 24),
            ),
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("History:"),
                  TextButton(onPressed: () {}, child: Text("Semua")),
                ],
              ),
            )
          ],
        ),
        Column(children: () {
          List<Widget> historyList = [];
          for (var i = history.length -1; i >= 0; i--) {
            historyList.add(
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      //width 60% of screen
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(history[i]['nama']!),
                          Text("-"),
                          Text(history[i]["date"]! + " " + history[i]["time"]!),
                        ],
                      ),
                    ),
                    //if checkin text green, if checkout textred
                    (() {
                      if (history[i]["status"] == "checkin") {
                        return Text(
                          "Check In",
                          style: TextStyle(color: Colors.green),
                        );
                      } else {
                        return Text(
                          "Check Out",
                          style: TextStyle(color: Colors.red),
                        );
                      }
                    }())
                  ],
                ),
              ),
            );
          }
          return historyList;
        }()),
      ]),
    );
  }
}
