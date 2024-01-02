// import 'package:flutter/material.dart';
// import 'package:my_notes/database/notes_database.dart';

// class SignUpScreen extends StatelessWidget {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   SignUpScreen({super.key});

//   void _signUp(BuildContext context) async {
//     final enteredUsername = _usernameController.text;
//     final enteredPassword = _passwordController.text;

//     if (enteredUsername.isNotEmpty && enteredPassword.isNotEmpty) {
//       final dbHelper = NotesDatabaseHelper();
//       final result = await dbHelper.createUser(enteredUsername, enteredPassword);

//       if (result > 0) {
//         Navigator.pushReplacementNamed(context, '/notes'); // Kayıt başarılıysa ana not listesi ekranına git
//       } else {
//         showDialog(
//           // Kayıt başarısız ise kullanıcıyı uyar
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text('Hata'),
//             content: const Text('Kayıt sırasında bir hata oluştu.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                 },
//                 child: const Text('Tamam'),
//               ),
//             ],
//           ),
//         );
//       }
//     } else {
//       // Boş alan varsa kullanıcıyı uyar
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text('Hata'),
//           content: const Text('Kullanıcı adı veya şifre boş olamaz.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//               child: const Text('Tamam'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kaydol'),
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
//                 _signUp(context);
//               },
//               child: const Text('Kaydol'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
