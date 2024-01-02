import 'package:flutter/material.dart';
import 'package:my_notes/database/users_database.dart';
import 'package:my_notes/model/user_model.dart';

// ignore: must_be_immutable
class RegisterButton extends StatelessWidget {
  RegisterButton({
    super.key,
    required this.userDB,
  });

  final formState2 = GlobalKey<FormState>();
  final FocusNode t1 = FocusNode();
  final FocusNode t2 = FocusNode();
  final UserDatabaseHelper userDB;
  String usrtext = "";
  String pswtxt = "";

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Register"),
                content: Form(
                  key: formState2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 300,
                    child: Column(
                      children: [
                        const Text("username"),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          focusNode: t1,
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
                        const Text("password"),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          focusNode: t2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password girilmeli";
                            }
                            return null;
                          },
                          onSaved: (newValue) => pswtxt = newValue!,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (formState2.currentState!.validate()) {
                                    formState2.currentState!.save();
                                    userDB.insert(UserModel(username: usrtext, password: pswtxt)).then((value) {
                                      if (value == -1) {
                                        showSnack("Could not user add", context);
                                      } else {
                                        showSnack("User added", context);
                                      }
                                    });
                                    formState2.currentState!.reset();
                                    FocusScope.of(context).requestFocus(FocusNode());
                                  }
                                },
                                child: const Text("Register")),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text("Register"));
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
