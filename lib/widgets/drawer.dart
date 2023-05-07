// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AppDrawer extends StatelessWidget {

  const AppDrawer({super.key});
  
  get catalog => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(  
        color: Colors.blue,
        child: ListView(
          children:  [
            DrawerHeader(
              
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text("User Name", style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold
                  ),),
                accountEmail: Text("usermail@gmail.com", style: TextStyle(color: Colors.white),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile-pic2.jpg"),
                ),
              ),
            ),

            ListTile(                                                                         //1st Tiltle
              leading: Icon(CupertinoIcons.home, color: Colors.red,),   // Use Cupertino Icons Or Icons
              title: Text("Home", textScaleFactor: 1.3,),    
            ),
           
             ListTile(                                                                     //5th Title
             leading: Icon(CupertinoIcons.gear, color: Colors.red,),        
              title: Text("Settings", textScaleFactor: 1.3,),
              onTap: () {
                //Navigator.pushNamed(context, Myroutes.settingsRoute);
              },
                 
            )

          ],    
        ),
      ),
    );
  }
}