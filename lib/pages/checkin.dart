import 'package:flutter/material.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  //array of history either checkin or checkout with the date and time
  int isCheckIn = 0;
  List<Map<String, String>> history = [
    {"date": "12/12/2021", "time": "12:00", "status": "checkin"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkout"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkin"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkout"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkin"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkout"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkin"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkout"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkin"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkout"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkin"},
    {"date": "12/12/2021", "time": "12:00", "status": "checkout"}
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Row(children: [
        Expanded(
          child: Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //margin x = 5

            //container again with full width but margin x = 5
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              "Latihan",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, color: const Color.fromARGB(255, 33, 212, 243)),
            ),
          ),
        )
      ]),
      Row(children: [
        Expanded(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          //margin x = 5
          decoration: BoxDecoration(
            //colors from rgb 211,211,211

            color: Color.fromARGB(148, 211, 211, 211),
            borderRadius: BorderRadius.circular(10),
          ),
          //container again with full width but margin x = 5
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: isCheckIn == 0
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      isCheckIn = 1;
                      //add the checkin time  and date of current date and time to the history array
                      history.add({
                        "date": "12/12/2021",
                        "time": "12:00",
                        "status": "checkin"
                      });
                    });
                  },
                  child: Text(
                    "Check In",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    setState(() {
                      isCheckIn = 0;
                      //add the checkout time  and date of current date and time to the history array
                      history.add({
                        "date": "12/12/2021",
                        "time": "12:00",
                        "status": "checkout"
                      });
                    });
                  },
                  child: Text(
                    "Check Out",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  )),
        )),
      ]),
      const Divider(
        height: 20,
        thickness: 2,
        indent: 5,
        endIndent: 5,
      ),
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
        for (var i = history.length - 1; i >= 0; i--) {
          historyList.add(
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(history[i]["date"]! + " " + history[i]["time"]!),
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
    ]);
  }
}
