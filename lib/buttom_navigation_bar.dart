import 'package:flutter/material.dart';

import 'Screens/FriendsBirthday.dart'; import 'Screens/HomeScreen.dart'; import 'Screens/addfriend.dart'; import 'Screens/nationalDay.dart';

class ButtomNavigationBar extends StatefulWidget { const ButtomNavigationBar({super.key});

@override State createState() => _ButtomNavigationBarState(); }

class _ButtomNavigationBarState extends State { int _selectedIndex = 0; final List _pages = [ const SpecialDayPage(), const NationalDayPage(), const FriendsBirthdayPage(), AddFriendPage(), ]; void _onItemTapped(int index) { setState(() { _selectedIndex = index; }); }

@override Widget build(BuildContext context) { return Scaffold( body: _pages[_selectedIndex], bottomNavigationBar: BottomNavigationBar( type: BottomNavigationBarType.fixed, currentIndex: _selectedIndex, onTap: _onItemTapped, selectedItemColor: Colors.deepPurple, unselectedItemColor: Colors.grey, items: const [ BottomNavigationBarItem(icon: Icon(Icons.home), label: ""), BottomNavigationBarItem(icon: Icon(Icons.flag), label: ""), BottomNavigationBarItem(icon: Icon(Icons.cake), label: ""), BottomNavigationBarItem(icon: Icon(Icons.person_add), label: ""), ], ), ); } }
