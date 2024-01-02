import 'package:flutter/material.dart';
import 'package:my_notes/database/notes_database.dart';
import 'package:my_notes/model/notes_model.dart';

class NoteAdd extends StatefulWidget {
  NoteAdd({super.key, required this.id});
  int? id;
  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  static final formState = GlobalKey<FormState>();
  final FocusNode t1 = FocusNode();
  final FocusNode t2 = FocusNode();
  final NotesDatabaseHelper notesDb = NotesDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    String titletxt = "";
    String contenttxt = "";
    return Form(
      key: formState,
      child: SizedBox(
          height: 300,
          child: Column(
            children: [
              const Text("Title:"),
              TextFormField(
                focusNode: t1,
                keyboardType: TextInputType.text,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(t2);
                },
                onSaved: (newValue) => titletxt = newValue!,
              ),
              const Text("Content:"),
              TextFormField(
                focusNode: t2,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Content is required";
                  }
                  return null;
                },
                onSaved: (newValue) => contenttxt = newValue!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      DateTime nowTime = DateTime.now();
                      String nowTimeS = nowTime.toString();
                      if (formState.currentState!.validate()) {
                        formState.currentState!.save();
                        notesDb
                            .insert(NoteModel(
                          title: titletxt,
                          content: contenttxt,
                          userID: widget.id,
                          date: nowTimeS,
                        ))
                            .then((value) {
                          if (value == false) {
                            showSnack("Could not note add", context);
                          } else {
                            showSnack("Note added", context);
                          }
                          formState.currentState!.reset();
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel")),
                ],
              )
            ],
          )),
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
