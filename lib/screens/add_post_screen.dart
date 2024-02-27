import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  final String distnace;
  final String timetaken;

  const AddPostScreen({
    Key? key,
    required this.distnace,
    required this.timetaken,
  }) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  void postImage(
      String uid, String username, String distance, String timetaken) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        uid,
        username,
        distance,
        timetaken,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Material(
          elevation: 5,
          child: Container(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0),
                    ),
                    TextButton(
                      onPressed: () {
                        postImage(
                          userProvider.getUser.uid,
                          userProvider.getUser.username,
                          widget.distnace,
                          widget.timetaken,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Post",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      ),
                    )
                  ],
                ),
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

      // POST FORM
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05)),
          isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                const Icon(Icons.directions_run),
                Text(
                  widget.distnace,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(15)),
                const Icon(Icons.timer),
                Text(
                  widget.timetaken,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ],
          ),
          const Divider(),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05)),
          Material(
            elevation: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    hintText: "Write a caption...", border: InputBorder.none),
                maxLines: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
