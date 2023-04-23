// import 'package:booksgrid/screens/profile.dart';
// import 'package:booksgrid/screens/settings.dart';
// import 'package:flutter/material.dart';
 
// import 'package:booksgrid/main.dart';
 
// class MyScaffold extends StatelessWidget {
//   final Widget body;
//   final String pageTitle;
 
//   const MyScaffold({Key? key, required this.body, required this.pageTitle})
//       : super(key: key);
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(pageTitle),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               // TODO: Implement drawer functionality
//               drawer:
//               SizedBox(
//                 width: 280,
//                 child: Drawer(
//                   elevation: 16,
//                   child: Align(
//                     alignment: const AlignmentDirectional(-0.1, 0),
//                     child: ListView(
//                       padding: EdgeInsets.zero,
//                       scrollDirection: Axis.vertical,
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 217.9,
//                           decoration: const BoxDecoration(
//                             color: Colors.blue,
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               Align(
//                                 alignment:
//                                     const AlignmentDirectional(-0.1, -0.2),
//                                 child: Padding(
//                                   padding: const EdgeInsetsDirectional.fromSTEB(
//                                       75, 30, 0, 2),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         width: 129,
//                                         height: 129,
//                                         clipBehavior: Clip.antiAlias,
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Image.network(
//                                           'https://picsum.photos/seed/716/600',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       InkWell(
//                                         onTap: _pickImages,
//                                         child: const SizedBox(
//                                           width: 50,
//                                           height: 50,
//                                           child: Icon(
//                                             Icons.camera_alt,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment:
//                                     const AlignmentDirectional(-0.15, -0.25),
//                                 child: Padding(
//                                   padding: const EdgeInsetsDirectional.fromSTEB(
//                                       0, 10, 0, 5),
//                                   child: Text(
//                                     '${loggedInUser.userName}\n${loggedInUser.email}',
//                                     textAlign: TextAlign.center,
//                                     style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 17,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Align(
//                           alignment: const AlignmentDirectional(1, 0.15),
//                           child: Padding(
//                             padding: const EdgeInsetsDirectional.fromSTEB(
//                                 0, 10, 0, 10),
//                             child: InkWell(
//                               onTap: () async {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: ((context) =>
//                                             (const HomePage()))));
//                               },
//                               child: const ListTile(
//                                 leading: Icon(
//                                   Icons.home_sharp,
//                                   color: Colors.blue,
//                                 ),
//                                 title: Text(
//                                   'Home',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 17,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 trailing: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: Color(0xFF303030),
//                                   size: 20,
//                                 ),
//                                 tileColor: Colors.white,
//                                 dense: false,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                             padding: const EdgeInsetsDirectional.fromSTEB(
//                                 0, 10, 0, 10),
//                             child: InkWell(
//                               onTap: () async {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: ((context) =>
//                                             (const Profile()))));
//                               },
//                               child: const ListTile(
//                                 leading: Icon(
//                                   Icons.location_history,
//                                   color: Colors.blue,
//                                 ),
//                                 title: Text(
//                                   'Profile',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 17,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 trailing: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: Color(0xFF303030),
//                                   size: 20,
//                                 ),
//                                 tileColor: Colors.white,
//                                 dense: false,
//                               ),
//                             )),
//                         Padding(
//                             padding: const EdgeInsetsDirectional.fromSTEB(
//                                 0, 10, 0, 10),
//                             child: InkWell(
//                               onTap: () async {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: ((context) =>
//                                             (const NotificationsPage()))));
//                               },
//                               child: const ListTile(
//                                 leading: Icon(
//                                   Icons.notifications_active,
//                                   color: Colors.blue,
//                                 ),
//                                 title: Text(
//                                   'Notifications',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 17,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 trailing: Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: Color(0xFF303030),
//                                   size: 20,
//                                 ),
//                                 tileColor: Colors.white,
//                                 dense: false,
//                               ),
//                             )),
//                         Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               0, 10, 0, 10),
//                           child: InkWell(
//                             onTap: () async {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: ((context) =>
//                                           (const SettingsPage()))));
//                             },
//                             child: const ListTile(
//                               leading: Icon(
//                                 Icons.settings,
//                                 color: Colors.blue,
//                               ),
//                               title: Text(
//                                 'Settings',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 17,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Color(0xFF303030),
//                                 size: 20,
//                               ),
//                               tileColor: Colors.white,
//                               dense: false,
//                             ),
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
//                           child: ListTile(
//                             leading: Icon(
//                               Icons.plumbing,
//                               color: Colors.blue,
//                             ),
//                             title: Text(
//                               'Plugins',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             trailing: Icon(
//                               Icons.arrow_forward_ios,
//                               color: Color(0xFF303030),
//                               size: 20,
//                             ),
//                             tileColor: Colors.white,
//                             dense: false,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               0, 10, 0, 10),
//                           child: InkWell(
//                             onTap: () async {
//                               Logout(context);
//                             },
//                             child: const ListTile(
//                               leading: Icon(
//                                 Icons.logout,
//                                 color: Colors.blue,
//                               ),
//                               title: Text(
//                                 'Log Out',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 17,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               tileColor: Colors.white,
//                               dense: false,
//                               contentPadding:
//                                   EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const UserProfile(),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: body,
//         ),
//       ),
//     );
//   }
// }
 
// class UserProfile extends StatelessWidget {
//   const UserProfile({Key? key});
 
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           CircleAvatar(
//             backgroundImage: AssetImage('assets/user_profile_picture.jpg'),
//             radius: 20.0,
//           ),
//           SizedBox(height: 4.0),
//           Text(
//             'John Doe',
//             style: TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             'Location',
//             style: TextStyle(
//               fontSize: 12.0,
//             ),
//           ),
//           Text(
//             'Contact',
//             style: TextStyle(
//               fontSize: 12.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }