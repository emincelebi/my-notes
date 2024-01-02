import 'package:flutter/material.dart';

class NoteListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notes = [
    {
      'id': 1,
      'title': 'Alışveriş Listesi',
      'content': 'Süt, ekmek, yumurta alınacak.',
      'date': '12 Ocak 2023',
      'userId': 1,
      'username': 'admin',
    },
    {
      'id': 2,
      'title': 'ToDo Listesi',
      'content': 'Proje bitiş tarihi yaklaşıyor.',
      'date': '15 Ocak 2023',
      'userId': 2,
      'username': 'user123',
    },
  ];

  NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlar'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note['title']),
            subtitle: Text('Yazan: ${note['username']}'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Not detayları ekranına git
              // Burada notun detaylarına erişebilirsin: note['id'], note['content'] vb.
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni not ekleme ekranına git
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
