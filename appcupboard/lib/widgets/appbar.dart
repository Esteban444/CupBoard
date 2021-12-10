import 'package:flutter/material.dart';

class MenuAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 66,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo[900],
              ),
              child: Text('Menu',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            title: Text('Home',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, 'home');
            },
          ),
          ListTile(
            title: Text('Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, 'category');
            },
          ),
          ListTile(
            title: Text('CupBoard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, 'cupboard');
            },
          ),
          ListTile(
            title: Text('Mark',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, 'mark');
            },
          ),
          ListTile(
            title: Text('Product',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, 'product');
            },
          ),
        ],
      ),
    );
  }
}
