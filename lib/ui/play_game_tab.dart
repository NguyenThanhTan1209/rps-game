import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rps_game/bloc/game_bloc.dart';
import 'package:rps_game/bloc/game_event.dart';
import 'package:rps_game/bloc/game_state.dart';
import 'package:rps_game/data/game_match.dart';

import 'option_game_widget.dart';

enum GameFlag { wait, playing, end }

enum GameOption { paper, rock, scissors }

class PlayGameTab extends StatefulWidget {
  const PlayGameTab({super.key});

  @override
  State<PlayGameTab> createState() => _PlayGameTabState();
}

class _PlayGameTabState extends State<PlayGameTab> with AutomaticKeepAliveClientMixin{
  dynamic gameFlag = GameFlag.wait;

  @override
  Widget build(BuildContext context) {
    return gameFlag == GameFlag.wait
        ? Center(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    gameFlag = GameFlag.playing;
                  });
                },
                child: const Text('Bắt đầu')),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<GameBloc, GameState>(builder: (context, state) {
                  if (state is GameWinState) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OptionWidget(choice: state.gameMatch.opponentChoice),
                          Text(
                            state.gameMatch.result,
                            style: const TextStyle(color: Colors.green),
                          ),
                          OptionWidget(choice: state.gameMatch.myChoice),
                        ],
                      ),
                    );
                  } else if (state is GameLoseState) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OptionWidget(choice: state.gameMatch.opponentChoice),
                          Text(
                            state.gameMatch.result,
                            style: const TextStyle(color: Colors.red),
                          ),
                          OptionWidget(choice: state.gameMatch.myChoice),
                        ],
                      ),
                    );
                  } else if (state is GameDueState) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OptionWidget(choice: state.gameMatch.opponentChoice),
                          Text(
                            state.gameMatch.result,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          OptionWidget(choice: state.gameMatch.myChoice),
                        ],
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text('Hãy lựa chọn kéo búa bao'),
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Image.asset(
                        'assets/scissors.png',
                        width: 100,
                        height: 100,
                      ),
                      onTap: () {
                        context.read<GameBloc>().add(ChooseOptionEvent(gameChoice: GameChoice.scissors));
                      },
                    ),
                    InkWell(
                      child: Image.asset(
                        'assets/rock.png',
                        width: 100,
                        height: 100,
                      ),
                      onTap: () {
                        context.read<GameBloc>().add(ChooseOptionEvent(gameChoice: GameChoice.rock));
                      },
                    ),
                    InkWell(
                      child: Image.asset(
                        'assets/paper.png',
                        width: 100,
                        height: 100,
                      ),
                      onTap: () {
                        context.read<GameBloc>().add(ChooseOptionEvent(gameChoice: GameChoice.paper));
                      },
                    ),
                  ],
                )
              ],
            ),
          );
  }
  
  @override
  bool get wantKeepAlive => true;
}