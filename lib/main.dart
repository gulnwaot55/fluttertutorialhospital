import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'App.dart';

void main(){
  Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
