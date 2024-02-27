import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/utils/global_variable.dart';
import '/widgets/post_card.dart';
import 'dart:math' as math;

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Material(
          elevation: 5,
          child: Container(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Feed Screen',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 22,
                    )),
              ),
            ),
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
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
