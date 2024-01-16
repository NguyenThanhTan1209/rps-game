import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rps_game/bloc/game_bloc.dart';
import 'package:rps_game/bloc/game_event.dart';
import 'package:rps_game/bloc/game_state.dart';
import 'package:rps_game/bloc/list_score_bloc.dart';
import 'package:rps_game/bloc/list_score_event.dart';
import 'package:rps_game/data/game_match.dart';
import 'package:rps_game/data/user.dart';

import '../widget/option_game_widget.dart';

enum GameFlag { wait, playing, end }

enum GameOption { paper, rock, scissors }

class PlayGameTab extends StatefulWidget {
  const PlayGameTab({super.key});

  @override
  State<PlayGameTab> createState() => _PlayGameTabState();
}

class _PlayGameTabState extends State<PlayGameTab>
    with AutomaticKeepAliveClientMixin {
  dynamic gameFlag = GameFlag.wait;
  late int _currentPoint;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _currentPoint = 0;
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

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
                Text(
                  'Điểm hiện tại: $_currentPoint',
                  style: const TextStyle(fontSize: 30),
                ),
                BlocConsumer<GameBloc, GameState>(
                  builder: (context, state) {
                    if (state is GameLoadingState) {
                      return const Expanded(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    } else if (state is GameWinState) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OptionWidget(
                                choice: state.gameMatch.opponentChoice),
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
                            OptionWidget(
                                choice: state.gameMatch.opponentChoice),
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
                            OptionWidget(
                                choice: state.gameMatch.opponentChoice),
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
                  },
                  listener: (context, state) {
                    if (state is GameWinState) {
                      setState(() {
                        _currentPoint++;
                      });
                    }
                    if (state is GameLoseState) {
                      if (_currentPoint > 0) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Điểm số của bạn là: $_currentPoint'),
                              content: TextField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Nhập tên của bạn để lưu'),
                                controller: _textEditingController,
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      final DateTime now = DateTime.now();
                                      final DateFormat formatter =
                                          DateFormat('dd/MM/yyyy - hh:mm');
                                      final String dateFormatted =
                                          formatter.format(now);

                                      context.read<ListScoreBloc>().add(
                                            AddNewScore(
                                              user: User(
                                                id: DateTime.now()
                                                    .millisecondsSinceEpoch,
                                                userName:
                                                    _textEditingController.text,
                                                point: _currentPoint,
                                                createDate: dateFormatted,
                                              ),
                                            ),
                                          );
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _currentPoint = 0;
                                      });
                                    },
                                    child: const Text('Lưu')),
                                OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _currentPoint = 0;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Huỷ')),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
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
                        context.read<GameBloc>().add(
                            ChooseOptionEvent(gameChoice: GameChoice.scissors));
                      },
                    ),
                    InkWell(
                      child: Image.asset(
                        'assets/rock.png',
                        width: 100,
                        height: 100,
                      ),
                      onTap: () {
                        context.read<GameBloc>().add(
                            ChooseOptionEvent(gameChoice: GameChoice.rock));
                      },
                    ),
                    InkWell(
                      child: Image.asset(
                        'assets/paper.png',
                        width: 100,
                        height: 100,
                      ),
                      onTap: () {
                        context.read<GameBloc>().add(
                            ChooseOptionEvent(gameChoice: GameChoice.paper));
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
