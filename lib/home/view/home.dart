import 'package:desk_reservation/home/home.dart';
import 'package:ews_repository/ews_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context.read<EWSRepository>()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print(state.desk);
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Desk Reservation')),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: state.desk,
                  items: state.desks.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      context.read<HomeBloc>().add(DeskChanged(newValue));
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Utiliser un FutureBuilder ou setState pour mettre à jour l'affichage
                    context.read<HomeBloc>().add(CheckReservation());
                  },
                  child: const Text('Voir disponibilité'),
                ),
                const SizedBox(height: 50),
                if (state.status.isSuccess)
                  Text(
                    state.reservedBy != null
                        ? 'Réservé par ${state.reservedBy}'
                        : 'Non réservé',
                    style: const TextStyle(fontSize: 18),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
