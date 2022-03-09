import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Player/PositionSeekWidget.dart';
import '../../constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Player/PlayingControls.dart';
import '../../Player/PositionSeekWidget.dart';
import '../../Player/SongsSelector.dart';

class VoiceOver extends StatefulWidget {
  final String nameHolder;
  final int selectedLanguage;
  final List<String> voiceOversHolder;
  final List<String> voiceOverTitlesHolder;
  final List<String> voiceOverSlideshowHolder;
  final List<String> scriptsHolder;

  VoiceOver({
    Key? key,
    required this.nameHolder,
    required this.selectedLanguage,
    required this.voiceOversHolder,
    required this.voiceOverTitlesHolder,
    required this.voiceOverSlideshowHolder,
    required this.scriptsHolder,
  }) : super(key: key);

  @override
  _VoiceOverState createState() => _VoiceOverState(nameHolder, selectedLanguage, voiceOversHolder,
      voiceOverTitlesHolder, voiceOverSlideshowHolder, scriptsHolder);
}

class _VoiceOverState extends State<VoiceOver> {

  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];

  String nameHolder;
  int selectedLanguage;
  List<String> voiceOversHolder;
  List<String> voiceOverTitlesHolder;
  List<String> voiceOverSlideshowHolder;
  List<String> scriptsHolder;
  _VoiceOverState(this.nameHolder, this.selectedLanguage, this.voiceOversHolder,
      this.voiceOverTitlesHolder, this.voiceOverSlideshowHolder, this.scriptsHolder);

  final audios = <Audio>[];

  String _selectedItem = 'Please Select A Track';
  String currentScript = 'No Track Selected';
  int index = 0;

  bool screen_changed = true;

  setAudios() async{

    for(int i = 0; i < voiceOversHolder.length; i++) {
      audios.add(
          Audio.network(
            voiceOversHolder[i],
            metas: Metas(
              title: voiceOverTitlesHolder[i],
              artist: nameHolder,
              album: nameHolder,
              image: MetasImage.network(
                  voiceOverSlideshowHolder[i]),
            )));
    }
    setState(() {
      _selectedItem = voiceOverTitlesHolder[0];
      currentScript = scriptsHolder[0];
    });

    for(int i = 0; i < audios.length; i++) {
      print(audios[i]);
    }

  }

  // final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void initState() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _assetsAudioPlayer.playlistFinished.listen((data) {
      print('finished : $data');
    });
    _assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    });
    _assetsAudioPlayer.current.listen((data) {
      print('current : $data');
    });
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    super.initState();
    setAudios();
    openPlayer();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  // String loopModeText(LoopMode loopMode) {
  //   switch (loopMode) {
  //     case LoopMode.none:
  //       return 'Not looping';
  //     case LoopMode.single:
  //       return 'Looping single';
  //     case LoopMode.playlist:
  //       return 'Looping playlist';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // FinitePager(
          //   opacity: 0.4,
          //   // scaleX: 1,
          //   // scaleY: 1,
          //   // pageSnapping: false,
          //   pagerType: PagerType.stack,
          //   overscroll: -300,
          //   scrollDirection: Axis.horizontal,
          //   children: [
          //
          //   ],
          //
          //   // children: <Widget>[ // Add your child here
          //   //   Image.asset("assets/Test/museum1.jpg"),
          //   //   Container(
          //   //   width: size.width,
          //   //   color: Colors.deepPurple,
          //   //     child: Image.asset("assets/Test/museum2.jpg"),
          //   //   ),
          //   //   Container(
          //   //     color: Colors.red,
          //   //     child: Center(
          //   //       child: Card(
          //   //         shape: CircleBorder(),
          //   //         child: Image.asset("images/watch_2.jpg"),
          //   //       ),
          //   //     ),
          //   //   ),
          //   //   Container(
          //   //     color: Colors.yellow,
          //   //     child: Center(
          //   //       child: Card(
          //   //         shape: CircleBorder(),
          //   //         child: Image.asset("images/watch_3.jpg"),
          //   //       ),
          //   //     ),
          //   //   ),
          //   //   Container(
          //   //     color: Colors.lightBlue,
          //   //     child: Center(
          //   //       child: Card(
          //   //         shape: CircleBorder(),
          //   //         child: Image.asset("images/watch_4.jpg"),
          //   //       ),
          //   //     ),
          //   //   ),
          //   //   Container(
          //   //     color: Colors.green,
          //   //     child: Center(
          //   //       child: Card(
          //   //         shape: CircleBorder(),
          //   //         child: Image.asset("images/watch_1.jpg"),
          //   //       ),
          //   //     ),
          //   //   ),
          //   //   Container(
          //   //     color: Colors.orange,
          //   //     child: Center(
          //   //       child: Card(
          //   //         shape: CircleBorder(),
          //   //         child: Image.asset("images/watch_2.jpg"),
          //   //       ),
          //   //     ),
          //   //   ),
          //   // ],
          // ),

          // Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     // image: AssetImage("assets/Test/museum2.jpg"),
            //     image: NetworkImage(voiceOverSlideshowHolder[index]),
            //     // image: NetwrokImage(_assets),
            //     colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          StreamBuilder<Playing?>(
                stream: _assetsAudioPlayer.current,
                builder: (context, playing) {
                  if (playing.data != null) {
                    final myAudio = find(
                        audios, playing.data!.audio.assetAudioPath);
                    print(playing.data!.audio.assetAudioPath);
                    return myAudio.metas.image?.path == null
                            ? const SizedBox()
                            : myAudio.metas.image?.type ==
                            ImageType.network
                            ? Container(
                        decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                          myAudio.metas.image!.path,
                          // height: size.height,
                          // width: size.width,
                          // fit: BoxFit.cover,
                        ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                              )))
                            : Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                                    image: AssetImage(
                                    myAudio.metas.image!.path,
                                    )
                                  )
                                ));
                          // myAudio.metas.image!.path,
                          // height: size.height,
                          // width: size.width,
                          // fit: BoxFit.cover,
                  }
                  return SizedBox.shrink();
                }),

          // ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor,),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.list_bullet, color: Colors.white),
                        onPressed: () {
                          _onTrackPressed();
                        },
                        iconSize: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Text(
                    //   _selectedItem,
                    //   style: TextStyle(color: kPrimaryLightColor, fontSize: 25, fontWeight: FontWeight.bold)
                    // ),
                    StreamBuilder<Playing?>(
                        stream: _assetsAudioPlayer.current,
                        builder: (context, playing) {
                          if (playing.data != null) {
                            final myAudio = find(
                                audios, playing.data!.audio.assetAudioPath);
                            print(playing.data!.audio.assetAudioPath);
                            return myAudio.metas.title == null
                                ? const SizedBox()
                                : Text(
                                (myAudio.metas.title).toString(),
                                  style: TextStyle(color: kPrimaryLightColor, fontSize: 25, fontWeight: FontWeight.bold)
                                );
                            // myAudio.metas.image!.path,
                            // height: size.height,
                            // width: size.width,
                            // fit: BoxFit.cover,
                          }
                          return SizedBox.shrink();
                        })
                  ],
                ),
                _assetsAudioPlayer.builderRealtimePlayingInfos(
                  builder: (context, RealtimePlayingInfos? infos) {
                    if (infos == null) {
                      return SizedBox();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PositionSeekWidget(
                          currentPosition: infos.currentPosition,
                          duration: infos.duration,
                          seekTo: (to) {
                            _assetsAudioPlayer.seek(to);
                          },
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(width: 50,),
                    // IconButton(
                    //   iconSize: 35,
                    //   onPressed: () {
                    //     _assetsAudioPlayer.previous().then((value) {
                    //       index = index - 1;
                    //       currentScript = scriptsHolder[index];
                    //       _selectedItem = voiceOverTitlesHolder[index].toString();
                    //     });
                    //   },
                    //   icon: Icon(Icons.navigate_before, color: Colors.white,),
                    // ),
                    // IconButton(
                    //   icon: Icon(CupertinoIcons.gobackward_30, color: Colors.white),
                    //   onPressed: () {
                    //     _assetsAudioPlayer.seekBy(Duration(seconds: -30));
                    //   },
                    //   iconSize: 45,
                    // ),


                    // StreamBuilder<Playing?>(
                    //   stream: _assetsAudioPlayer.current,
                    //   // initialData: false,
                    //   builder:
                    //       (context, playing) {
                    //     if(playing.data != null) {
                    //       final myAudio = find(
                    //         audios, playing.data!.audio.assetAudioPath);
                    //       print(playing.data!.audio.assetAudioPath);
                    //     // return IconButton(
                    //     //   onPressed: () {
                    //     //     _assetsAudioPlayer.playOrPause();
                    //     //   },
                    //     //   iconSize: 65,
                    //     //   color: Colors.white,
                    //     //   icon: Icon(snapshot.data == true
                    //     //       ? Icons.pause_circle_filled_rounded
                    //     //       : Icons.play_circle_fill_rounded),
                    //     // );
                    //
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: myAudio.metas.image?.path == null
                    //             ? Image.asset(
                    //                 'assets/Logo/1024.png',
                    //                 height: 150,
                    //                 width: 150,
                    //                 fit: BoxFit.contain,
                    //               )
                    //             : myAudio.metas.image?.type ==
                    //             ImageType.network
                    //             ? Image.network(
                    //           myAudio.metas.image!.path,
                    //           height: 150,
                    //           width: 150,
                    //           fit: BoxFit.contain,
                    //         )
                    //             : Image.asset(
                    //           'assets/Logo/1024.png',
                    //           height: 150,
                    //           width: 150,
                    //           fit: BoxFit.contain,
                    //         ),
                    //       );
                    //     }
                    //     return SizedBox.shrink();
                    //   }
                    // ),

                    _assetsAudioPlayer.builderCurrent(
                      builder: (context, Playing? playing){
                        return Column(
                          children: [
                            _assetsAudioPlayer.builderRealtimePlayingInfos(
                              builder: (context, RealtimePlayingInfos? infos) {
                                if (infos == null) {
                                  return SizedBox();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    PositionSeekWidget(
                                      currentPosition: infos.currentPosition,
                                      duration: infos.duration,
                                      seekTo: (to) {
                                        _assetsAudioPlayer.seek(to);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            // IconButton(
                            //   iconSize: 35,
                            //   onPressed: () {
                            //     _assetsAudioPlayer.previous().then((value) {
                            //       index = index - 1;
                            //       currentScript = scriptsHolder[index];
                            //       _selectedItem = voiceOverTitlesHolder[index].toString();
                            //     });
                            //   },
                            //   icon: Icon(Icons.navigate_before, color: Colors.white,),
                            // ),
                            // IconButton(
                            //   icon: Icon(CupertinoIcons.gobackward_30, color: Colors.white),
                            //   onPressed: () {
                            //     _assetsAudioPlayer.seekBy(Duration(seconds: -30));
                            //   },
                            //   iconSize: 45,
                            // ),
                            _assetsAudioPlayer.builderLoopMode(
                              builder: (context, loopMode){
                                return PlayerBuilder.isPlaying(
                                  player: _assetsAudioPlayer,
                                  builder: (context, isPlaying) {
                                    return PlayingControls(
                                      loopMode: LoopMode.playlist,
                                      isPlaylist: true,
                                      isPlaying: isPlaying,
                                      onStop: () {
                                        _assetsAudioPlayer.stop();
                                      },
                                      toggleLoop: () {
                                        _assetsAudioPlayer.toggleLoop();
                                      },
                                      onPlay: () {
                                        _assetsAudioPlayer.playOrPause();
                                      },
                                      onNext: () {
                                        //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                        _assetsAudioPlayer.next(
                                            keepLoopMode:
                                            true /*keepLoopMode: false*/);
                                      },
                                      onPrevious: () {
                                        _assetsAudioPlayer.previous(
                                          /*keepLoopMode: false*/);
                                      },
                                      on30Forward: () {
                                        _assetsAudioPlayer.seekBy(Duration(seconds: 30));
                                      },
                                      on30Backward: () {
                                        _assetsAudioPlayer.seekBy(Duration(seconds: -30));
                                      },
                                    );
                                  }
                                );
                              }
                            ),
                            // IconButton(
                            //   icon: Icon(CupertinoIcons.goforward_30, color: Colors.white),
                            //   onPressed: () {
                            //     _assetsAudioPlayer.seekBy(Duration(seconds: 30));
                            //   },
                            //   iconSize: 45,
                            // ),
                            // IconButton(
                            //   iconSize: 35,
                            //   icon: Icon(Icons.navigate_next, color: Colors.white),
                            //   onPressed: () {
                            //     _assetsAudioPlayer.next().then((value) {
                            //       setState((){
                            //         index = index + 1;
                            //         currentScript = scriptsHolder[index];
                            //         _selectedItem = voiceOverTitlesHolder[index].toString();
                            //       });
                            //     });
                            //   },
                            // ),
                          ],
                        );
                      }
                    ),

                    // _assetsAudioPlayer.builderCurrent(
                    //   builder: (BuildContext context, Playing? playing){
                    //     return SongsSelector(
                    //       audios: audios,
                    //       onPlaylistSelected: (myAudios){
                    //         _assetsAudioPlayer.open(
                    //           Playlist(audios: myAudios),
                    //           showNotification: true,
                    //           headPhoneStrategy:
                    //           HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                    //           audioFocusStrategy: AudioFocusStrategy.request(
                    //               resumeAfterInterruption: true),
                    //         );
                    //       },
                    //       onSelected: (myAudio) async {
                    //         try {
                    //           await _assetsAudioPlayer.open(
                    //             myAudio,
                    //             autoStart: true,
                    //             showNotification: true,
                    //             playInBackground: PlayInBackground.enabled,
                    //             audioFocusStrategy: AudioFocusStrategy.request(
                    //                 resumeAfterInterruption: true,
                    //                 resumeOthersPlayersAfterDone: true),
                    //             headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                    //             notificationSettings: NotificationSettings(
                    //               seekBarEnabled: true,
                    //               //stopEnabled: true,
                    //               //customStopAction: (player){
                    //               //  player.stop();
                    //               //}
                    //               //prevEnabled: false,
                    //               //customNextAction: (player) {
                    //               //  print('next');
                    //               //}
                    //               //customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
                    //               //customPauseIcon: AndroidResDrawable(name:'ic_pause_custom'),
                    //               //customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),
                    //             ),
                    //           );
                    //         } catch (e) {
                    //           print(e);
                    //         }
                    //       },
                    //       playing: playing,
                    //     );
                    //   }
                    // ),
                    SizedBox(
                      height: 30,
                    )

                    // IconButton(
                    //   icon: Icon(CupertinoIcons.goforward_30, color: Colors.white),
                    //   onPressed: () {
                    //     _assetsAudioPlayer.seekBy(Duration(seconds: 30));
                    //   },
                    //   iconSize: 45,
                    // ),
                    // IconButton(
                    //   iconSize: 35,
                    //   icon: Icon(Icons.navigate_next, color: Colors.white),
                    //   onPressed: () {
                    //     _assetsAudioPlayer.next().then((value) {
                    //       setState((){
                    //         index = index + 1;
                    //         currentScript = scriptsHolder[index];
                    //         _selectedItem = voiceOverTitlesHolder[index].toString();
                    //       });
                    //     });
                    //   },
                    // ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Divider(
                //   height: 5,
                //   thickness: 1,
                //   indent: 15,
                //   endIndent: 15,
                //   color: kPrimaryColor,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(0.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       IconButton(
                //         icon: Icon(CupertinoIcons.doc_text, color: Colors.white),
                //         onPressed: () {
                //           _onScriptPressed(currentScript);
                //         },
                //         iconSize: 30,
                //       ),
                //       SizedBox(width: size.width * 0.2),
                //       IconButton(
                //         icon: Icon(CupertinoIcons.list_bullet, color: Colors.white),
                //         onPressed: () {
                //           _onTrackPressed();
                //         },
                //         iconSize: 30,
                //       ),
                //     ],
                //   ),
                // ),
              ]
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.04,
            minChildSize: 0.04,
            maxChildSize: 0.6,
            builder: (context, ScrollController) {
              return SingleChildScrollView(
                controller: ScrollController,
                child: Container(
                  height: size.height * 0.6,
                  child: _buildScriptBottomNavigationMenu(currentScript),
                  decoration: BoxDecoration(
                    // color: Theme.of(context).canvasColor,
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                    )
                  )
                ),
              );

              // return SingleChildScrollView(
              //   controller: ScrollController,
              //   child: Container(
              //       height: 200,
              //       color: Colors.transparent,
              //       child: Container(
              //         child: _buildTrackBottomNavigationMenu(),
              //         decoration: BoxDecoration(
              //             color: Theme.of(context).canvasColor,
              //             borderRadius: BorderRadius.only(
              //               topLeft: const Radius.circular(20),
              //               topRight: const Radius.circular(20),
              //             )
              //         ),
              //       )
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

// BUILD THE BOTTOM SHEET OF SELECTING VOICE TRACK
  Column _buildTrackBottomNavigationMenu() {
    return Column(
      children: [
        Icon(
          // Icons.view_headline_sharp,
          Icons.space_bar_sharp,
          size: 25,
        ),
        Expanded(
          child: StreamBuilder(
              stream: _assetsAudioPlayer.current,
              builder: (BuildContext context,
                  AsyncSnapshot<Playing?> snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                final playing = snapshot.data!;
                return ListView.builder(
                  itemBuilder: (context, position) {
                    return ListTile(
                        title: Text((voiceOverTitlesHolder[position]).toString(),
                            style: TextStyle(
                              color: audios[position].path ==
                                  playing.audio.assetAudioPath
                                  ? Colors.blue
                                  : Colors.black,
                            )),
                        onTap: () {
                          _assetsAudioPlayer
                              .open(audios[position] /*, volume: 0.2*/);
                          setState(() {
                            currentScript = scriptsHolder[position];
                            index = position;
                          });
                          _selectItem((voiceOverTitlesHolder[position]).toString());
                        });
                  },
                  itemCount: voiceOversHolder.length,
                );
              }),
        ),
      ],
    );
  }

  void _onTrackPressed() {
    showModalBottomSheet(context: context, builder: (context) {
      return SingleChildScrollView(
        child: Container(
            height: 200,
            color: Color(0xFF737373),
            child: Container(
              // child: _buildTrackBottomNavigationMenu(),
              child: _assetsAudioPlayer.builderCurrent(
                  builder: (BuildContext context, Playing? playing){
                    return SongsSelector(
                      audios: audios,
                      onPlaylistSelected: (myAudios){
                        _assetsAudioPlayer.open(
                          Playlist(audios: myAudios),
                          loopMode: LoopMode.playlist,
                          showNotification: true,
                          headPhoneStrategy:
                          HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          audioFocusStrategy: AudioFocusStrategy.request(
                              resumeAfterInterruption: true),
                        );
                      },
                      onSelected: (myAudio) async {
                        try {
                          await _assetsAudioPlayer.open(
                            myAudio,
                            loopMode: LoopMode.playlist,
                            autoStart: true,
                            showNotification: true,
                            playInBackground: PlayInBackground.enabled,
                            audioFocusStrategy: AudioFocusStrategy.request(
                                resumeAfterInterruption: true,
                                resumeOthersPlayersAfterDone: true),
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            notificationSettings: NotificationSettings(
                              seekBarEnabled: true,
                              //stopEnabled: true,
                              //customStopAction: (player){
                              //  player.stop();
                              //}
                              //prevEnabled: false,
                              //customNextAction: (player) {
                              //  print('next');
                              //}
                              //customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
                              //customPauseIcon: AndroidResDrawable(name:'ic_pause_custom'),
                              //customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      playing: playing,
                    );
                  }
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                  )
              ),
            )
        ),
      );
    });
  }

  // void _onTrackPressed() {
  //   DraggableScrollableSheet(
  //     initialChildSize: 0.4,
  //     minChildSize: 0.2,
  //     maxChildSize: 0.6,
  //     builder: (context, ScrollController) {
  //       return SingleChildScrollView(
  //         controller: ScrollController,
  //         child: Container(
  //             height: 200,
  //             color: Color(0xFF737373),
  //             child: Container(
  //               child: _buildTrackBottomNavigationMenu(),
  //               decoration: BoxDecoration(
  //                   color: Theme.of(context).canvasColor,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: const Radius.circular(10),
  //                     topRight: const Radius.circular(10),
  //                   )
  //               ),
  //             )
  //         ),
  //       );
  //     },
  //   );
  // }

// BUILD THE BOTTOM SHEET FOR THE SCRIPT
  Column _buildScriptBottomNavigationMenu(currentScript) {
    return Column(
      children: [
        Icon(
          // Icons.view_headline_sharp,
          Icons.space_bar_sharp,
          size: 25,
        ),
        Expanded(
          child: Text(
            currentScript,
          ),
        ),
      ],
    );
  }

  void _onScriptPressed(currentScript) {
    showModalBottomSheet(context: context, builder: (context) {
      Size size = MediaQuery.of(context).size;
      return SingleChildScrollView(
        child: Container(
            height: size.height * 0.9,
            color: Color(0xFF737373),
            child: Container(
              child: _buildScriptBottomNavigationMenu(currentScript),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                  )
              ),
            )
        ),
      );
    });
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }

}