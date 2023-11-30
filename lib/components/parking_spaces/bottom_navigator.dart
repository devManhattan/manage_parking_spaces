import 'package:flutter/material.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/history_parking_spaces_page..dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/manage_parking_spaces_page.dart';

class BottomNavigatorParkingSpaces extends StatefulWidget {
  const BottomNavigatorParkingSpaces({super.key});

  @override
  State<BottomNavigatorParkingSpaces> createState() =>
      _BottomNavigatorParkingSpacesState();
}

class _BottomNavigatorParkingSpacesState
    extends State<BottomNavigatorParkingSpaces> {
  List<Widget> children = [
    MangeParkingSpacesPage(),
    HistoryParkingSpacesPage(),
  ];
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (index) {
            pageIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_car), label: "Vagas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "Histórico")
          ]),
    );
  }
}
