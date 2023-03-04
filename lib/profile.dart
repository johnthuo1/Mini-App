// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:booksgrid/main.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(130, 0, 0, 0),
          child: Text(
            'User Profile',
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: Center(
        
        child: SafeArea(
          child: GestureDetector(
            onTap: () async {},
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Container(
                    width: 120,
                    height: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://picsum.photos/seed/736/600',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text(
                  'John Thuo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                    child: DataTable(columns: [
                      DataColumn(
                        label: DefaultTextStyle.merge(
                          softWrap: true,
                          child: const Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: DefaultTextStyle.merge(
                          softWrap: true,
                          child: const Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ], rows: [
                      DataRow(cells: [
                        DataCell(Text("Name ", style: TextStyle(fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.bold))),
                        DataCell(Text("John Thuo"), showEditIcon: true)
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Email", style: TextStyle(fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.bold))),
                        DataCell(Text("j.mwangi@alustudent.com"), showEditIcon: true)
                      ]),
                      DataRow(
                          cells: [
                          DataCell(Text("No. of Books", style: TextStyle(fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.bold))), 
                          DataCell(Text("10"))])
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> (HomePage())));
      },
      child: Icon(Icons.arrow_back_ios),),
    );
  }
}
