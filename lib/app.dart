import 'package:desk_reservation/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ews_repository/ews_repository.dart';

class App extends StatelessWidget {
  const App({required EWSRepository ewsRepository, super.key})
      : _ewsRepository = ewsRepository;

  final EWSRepository _ewsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _ewsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
