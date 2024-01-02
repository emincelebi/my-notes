import 'package:flutter/material.dart';
import 'package:my_notes/database/users_database.dart';
import 'package:my_notes/view/note_add_view.dart';
import 'package:my_notes/view/sheet_view.dart';
import 'package:my_notes/view/register_view.dart';

class LoginView extends StatelessWidget with ProductSheetMixin {
  LoginView({
    super.key,
    required this.userDB,
  });

  static final formState = GlobalKey<FormState>();
  final FocusNode t1 = FocusNode();
  final FocusNode t2 = FocusNode();
  final UserDatabaseHelper userDB;

  @override
  Widget build(BuildContext context) {
    String usrtext = "";
    String pswtxt = "";
    return Form(
      key: formState,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("username:"),
            TextFormField(
              focusNode: t1,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Username girilmeli";
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(t2);
              },
              onSaved: (newValue) => usrtext = newValue!,
            ),
            const Divider(),
            const Text("Password"),
            TextFormField(
              focusNode: t2,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Şifre girilmeli";
                }
                return null;
              },
              onSaved: (newValue) => pswtxt = newValue!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      int? userId = await userDB.getId(usrtext);
                      if (formState.currentState!.validate()) {
                        formState.currentState!.save();
                        userDB.loginUser(usrtext, pswtxt).then((value) async {
                          if (value == false) {
                            showSnack("Could not user login", context);
                            formState.currentState!.reset();
                            FocusScope.of(context).requestFocus(FocusNode());
                          } else {
                            showSnack("User login", context);
                            var res = await showCustomSheet(context, NoteAdd(id: userId));
                            formState.currentState!.reset();
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (res is! String) {
                              Navigator.of(context).pop();
                            }
                          }
                        });
                      }
                    },
                    child: const Text("Login")),
                RegisterButton(
                  userDB: userDB,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
