import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runn_app/screens/feed_screen.dart';
import 'package:runn_app/screens/my_profile.dart';
import '../screens/home_page.dart';
import '/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const MapScreen(),
  const FeedScreen(),
  const SearchScreen(),
  MyProfile(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
