// import 'package:flutter/material.dart';
// import 'package:my_notes/database/notes_database.dart';
// import 'package:my_notes/database/users_database.dart';
// import 'package:my_notes/view/sign_up_screen.dart';

// class AdminLoginScreen extends StatelessWidget {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   AdminLoginScreen({super.key});

//   void _login(BuildContext context) async {
//   final enteredUsername = _usernameController.text;
//   final enteredPassword = _passwordController.text;

//   // Gerçek bir giriş kontrolü burada yapılmalı, şimdilik basit bir kontrol yapalım
//   final dbHelper = UserDatabaseHelper();
//   final isLoggedIn = await dbHelper.loginUser(enteredUsername, enteredPassword);

//   if (isLoggedIn) {
//     Navigator.pushReplacementNamed(context, '/notes'); // Giriş başarılıysa not listesi ekranına git
//   } else {
//     showDialog(
//       // Giriş başarısız ise kullanıcıyı uyar
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('Hata'),
//         content: Text('Geçersiz kullanıcı adı veya şifre.'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//             child: Text('Tamam'),
//           ),
//         ],
//       ),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Girişi'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextFormField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Kullanıcı Adı',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Şifre',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 _login(context);
//               },
//               child: const Text('Giriş Yap'),
//             ),
//             const SizedBox(height: 10.0),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignUpScreen()), // Kayıt ekranına git
//                 );
//               },
//               child: const Text('Kayıt Ol'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
