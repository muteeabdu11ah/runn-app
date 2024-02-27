import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/screens/profile_screen.dart';
import 'dart:math' as math;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Material(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(math.Random().nextDouble()),
                    Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(math.Random().nextDouble()),
                    Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(math.Random().nextDouble()),
                    Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(math.Random().nextDouble()),
                    Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(math.Random().nextDouble()),
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search for a user...',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                  ),
                  onFieldSubmitted: (String _) {
                    setState(() {
                      isShowUsers = true;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            uid: (snapshot.data! as dynamic).docs[index]['uid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['username'],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('datePublished')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Container();
              }),
    );
  }
}
