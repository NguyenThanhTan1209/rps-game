import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rps_game/bloc/list_score_bloc.dart';
import 'package:rps_game/bloc/list_score_event.dart';
import 'package:rps_game/bloc/list_score_state.dart';

class ListScoreTab extends StatefulWidget {
  const ListScoreTab({super.key});

  @override
  State<ListScoreTab> createState() => _ListScoreTabState();
}

class _ListScoreTabState extends State<ListScoreTab> {

  @override
  void initState() {
    context.read<ListScoreBloc>().add(GetScoreList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListScoreBloc, ListScoreState>(
      builder: (context, state) {
        if (state is ListScoreLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ListScoreSuccessState) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${state.listScore[index].point} - ${state.listScore[index].userName}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(state.listScore[index].createDate.toString()),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.listScore.length);
        } else if(state is ListScoreFailedState){
          return Center(
            child: Text(state.error),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
