import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/view/home/activties.dart';
import 'package:flutter_application_elixirscore/view/home/chat.dart';
import 'package:flutter_application_elixirscore/view/home/dashboard.dart';
import 'package:flutter_application_elixirscore/view/profile.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {  
  
  @override  
  _HomeState createState() => _HomeState();  
}  
  
class _HomeState extends State<Home> {  
  int _selectedIndex = 1;  
  static const List<Widget> _widgetOptions = <Widget>[  
    Dashboard(),
     ChatScreen(),
    Activities()  
   
  ];  
  
  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
     
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        items:  <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.favorite),  
             label: '',   
          ),  
          BottomNavigationBarItem(  
            icon: Image.asset(
              'assets/images/icon.png',
              width: 10.w,
            ),  
           label: '',  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            label: '',   
          ),  
        ],  
      //  type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,  
        iconSize: 30,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),  
    );  
  }  
}  