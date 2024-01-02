import 'package:flutter/material.dart';
import 'package:my_notes/database/notes_database.dart';
import 'package:my_notes/database/users_database.dart';
import 'package:my_notes/model/notes_model.dart';
import 'package:my_notes/model/user_model.dart';
import 'package:my_notes/view/login_view.dart';
import 'package:my_notes/view/note_add_view.dart';
import 'package:my_notes/view/sheet_view.dart';

enum Images { gok1, gok2, gok3, gok4 }

extension ImagesExtension on Images {
  String get imageName {
    switch (this) {
      case Images.gok1:
        return 'gokturk.jpeg';
      case Images.gok2:
        return 'gokturk2.jpeg';
      case Images.gok3:
        return 'gokturk3.jpg';
      case Images.gok4:
        return 'gokturk4.jpg';
      default:
        return '';
    }
  }

  String get imageUrl {
    return 'assets/images/$imageName';
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with ProductSheetMixin {
  late UserDatabaseHelper usrDb;
  late NotesDatabaseHelper noteDb;
  List<NoteModel> notes = [];

  @override
  void initState() {
    usrDb = UserDatabaseHelper();
    noteDb = NotesDatabaseHelper();
    connect();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      getNotes();
    });
  }

  List<Color> colors = [Colors.blue, Colors.white, Colors.blue, Colors.black];
  int currentColorIndex = 0;

  void changeBackgroundColor() {
    setState(() {
      currentColorIndex = (currentColorIndex + 1) % colors.length;
    });
  }

  connect() {
    getNotes();
  }

  getNotes([UserModel? user]) async {
    notes = await noteDb.getNotes(user);
    setState(() {});
  }

  Images currentImage = Images.gok1;

  void changeBackgroundImage() {
    setState(() {
      currentImage = currentImage == Images.gok4 ? Images.gok1 : Images.values[currentImage.index + 1];
    });
  }

  Color get appbarTitleColor => colors[currentColorIndex];
  Color get fabIconColor => currentColorIndex % 2 == 0 ? Colors.blue : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Notes",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: appbarTitleColor,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                changeBackgroundImage();
                changeBackgroundColor();
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
            ),
          ],
        ),
        body: Stack(children: [
          Image.asset(
            currentImage.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    String? datePart;
                    String? timePart;
                    String? fullPart;
                    if (notes[index].date != null) {
                      List<String> parts = notes[index].date!.split(' ');
                      datePart = parts[0];
                      timePart = parts[1];
                      List<String> timePartt = timePart.split('.');
                      timePart = timePartt[0];
                      fullPart = '$datePart $timePart';
                    }

                    return Card(
                      color: const Color.fromARGB(255, 75, 153, 192),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notes[index].title ?? ""),
                                  const SizedBox(height: 8),
                                  Text(notes[index].content ?? ""),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (fullPart != null) {
                                        showSnack(fullPart, context);
                                      }
                                    },
                                    child: Text(datePart ?? ""),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: notes[index].userID != null
                                            ? () async {
                                                var userID = notes[index].userID!;
                                                var users = await usrDb.getUsers(userID);
                                                if (users.isNotEmpty) {
                                                  showSnack(users.first.username.toString(), context);
                                                }
                                              }
                                            : null,
                                        icon: const Icon(Icons.person),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          int? notId = notes[index].id;
                                          if (notId != null) noteDb.delete(notId).then((value) => getNotes());
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ]),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Login"),
                      content: LoginView(userDB: usrDb),
                    );
                  },
                ).then((_) {
                  setState(() {
                    getNotes();
                  });
                });
              },
              child: Icon(Icons.add_box_outlined, color: fabIconColor),
            ),
            const SizedBox(width: 5),
            FloatingActionButton(
              onPressed: () {
                showCustomSheet(context, NoteAdd(id: null)).then((_) {
                  setState(() {
                    getNotes();
                  });
                });
              },
              child: Icon(Icons.add_circle_outline_outlined, color: fabIconColor),
            ),
          ],
        ));
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
