import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rps_game/bloc/game_bloc.dart';

import 'ui/play_game_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(create: (context){
          return GameBloc();
        })
      ],
      child: MaterialApp(
        title: 'Búa Kéo Bao',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DefaultTabController(length: 2, child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffff89a),
        title: const Text('Kéo búa bao'),
        bottom: const TabBar(tabs: [
        Tab(icon: Icon(Icons.gamepad_rounded),),
        Tab(icon: Icon(Icons.list_rounded))
      ]),),
      body: const TabBarView(children: [
        PlayGameTab(),
        Placeholder()
      ]),
    );
  }
}