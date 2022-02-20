import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_toury/Player/PositionSeekWidget.dart';
import '../../constants.dart';
import 'package:finite_coverflow/finite_coverflow.dart';
import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';

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
      audios.add(Audio.network(voiceOversHolder[i], metas: Metas(title: voiceOverTitlesHolder[i])));
    }
    setState(() {
      _selectedItem = voiceOverTitlesHolder[0];
      currentScript = scriptsHolder[0];
    });

    for(int i = 0; i < audios.length; i++) {
      print(audios[i]);
    }

  }

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void initState() {
    _assetsAudioPlayer.playlistFinished.listen((data) {
      print('finished : $data');
    });
    _assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    });
    _assetsAudioPlayer.current.listen((data) {
      print('current : $data');
    });
    super.initState();
    setAudios();
    openPlayer();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  String loopModeText(LoopMode loopMode) {
    switch (loopMode) {
      case LoopMode.none:
        return 'Not looping';
      case LoopMode.single:
        return 'Looping single';
      case LoopMode.playlist:
        return 'Looping playlist';
    }
  }

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

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage("assets/Test/museum2.jpg"),
                image: NetworkImage(voiceOverSlideshowHolder[index]),
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    Text(_selectedItem, style: TextStyle(color: kPrimaryLightColor, fontSize: 25, fontWeight: FontWeight.bold)),
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
                    IconButton(
                      iconSize: 35,
                      onPressed: () {
                        _assetsAudioPlayer.previous().then((value) {
                          index = index - 1;
                          currentScript = scriptsHolder[index];
                          _selectedItem = voiceOverTitlesHolder[index].toString();
                        });
                      },
                      icon: Icon(Icons.navigate_before, color: Colors.white,),
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.gobackward_30, color: Colors.white),
                      onPressed: () {
                        _assetsAudioPlayer.seekBy(Duration(seconds: -30));
                      },
                      iconSize: 45,
                    ),
                    StreamBuilder(
                      stream: _assetsAudioPlayer.isPlaying,
                      initialData: false,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return IconButton(
                          onPressed: () {
                            _assetsAudioPlayer.playOrPause();
                          },
                          iconSize: 65,
                          color: Colors.white,
                          icon: Icon(snapshot.data == true
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_fill_rounded),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.goforward_30, color: Colors.white),
                      onPressed: () {
                        _assetsAudioPlayer.seekBy(Duration(seconds: 30));
                      },
                      iconSize: 45,
                    ),
                    IconButton(
                      iconSize: 35,
                      icon: Icon(Icons.navigate_next, color: Colors.white),
                      onPressed: () {
                        _assetsAudioPlayer.next().then((value) {
                          setState((){
                            index = index + 1;
                            currentScript = scriptsHolder[index];
                            _selectedItem = voiceOverTitlesHolder[index].toString();
                          });
                        });
                      },
                    ),
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
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       icon: Icon(CupertinoIcons.back),
    //     ),
    //     iconTheme: IconThemeData(color: kPrimaryColor),
    //     automaticallyImplyLeading: true,
    //     centerTitle: true,
    //     title: Text(
    //       nameHolder,
    //       style: TextStyle(
    //         color: kPrimaryColor,
    //       ),
    //     ),
    //   ),
    //
    //   // body: Column(
    //   //   // fit: StackFit.passthrough,
    //   //   children: [
    //   //     Container(
    //   //       // alignment: Alignment.topCenter,
    //   //       height: size.height * 0.6,
    //   //       child: GestureDetector(
    //   //         onTap: () {
    //   //           debugPrint("Screen Changed");
    //   //           setState((){
    //   //             screen_changed = !screen_changed;
    //   //           });
    //   //         },
    //   //         child: screen_changed ? Column(
    //   //           mainAxisAlignment: MainAxisAlignment.start,
    //   //           children: [
    //   //             Container(
    //   //                 child: CarouselSlider(
    //   //                   options: CarouselOptions(
    //   //                     autoPlay: true,
    //   //                     // height: size.height * 0.6,
    //   //                   ),
    //   //                   items: voiceOverSlideshowHolder
    //   //                       .map((item) => Container(
    //   //                         // alignment: Alignment.topCenter,
    //   //                         // height: size.height * 0.6,
    //   //                         color: Colors.grey,
    //   //                         child: Center(
    //   //                           child:
    //   //                             Image.network(item, fit: BoxFit.fitWidth, width: size.width)),
    //   //                   ))
    //   //                       .toList(),
    //   //                 ),
    //   //               // alignment: Alignment.topCenter,
    //   //             ),
    //   //             Container(
    //   //               height: (size.height*0.6) - (size.height*0.6),
    //   //               color: Colors.red,
    //   //             )
    //   //           ],
    //   //         )
    //   //             : Container(
    //   //               height: size.height * 0.6,
    //   //               width: size.width,
    //   //               color: Colors.red,
    //   //               child: Expanded(
    //   //                  child: Text(
    //   //                   currentScript,
    //   //           ),
    //   //         ),
    //   //             ),
    //   //       ),
    //   //     ),
    //   //
    //   //
    //   //   ],
    //   // ),
    //
    //   body: Container(
    //     child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             Container(
    //                   child: CarouselSlider(
    //                     options: CarouselOptions(
    //                       autoPlay: true,
    //                       height: size.height * 0.45,
    //                     ),
    //                     items: voiceOverSlideshowHolder
    //                         .map((item) => Container(
    //                       height: size.height * 0.5,
    //                           color: Colors.grey,
    //                           child: Center(
    //                             child:
    //                               Image.network(item, fit: BoxFit.cover, width: size.width)),
    //                     ))
    //                         .toList(),
    //                   )
    //             ),
    //             Divider(
    //               thickness: 2,
    //               indent: 15,
    //               endIndent: 15,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Text(_selectedItem, style: TextStyle(fontSize: 18)),
    //               ],
    //             ),
    //             _assetsAudioPlayer.builderRealtimePlayingInfos(
    //               builder: (context, RealtimePlayingInfos? infos) {
    //                 if (infos == null) {
    //                   return SizedBox();
    //                 }
    //                 return Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     PositionSeekWidget(
    //                       currentPosition: infos.currentPosition,
    //                       duration: infos.duration,
    //                       seekTo: (to) {
    //                         _assetsAudioPlayer.seek(to);
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 // SizedBox(width: 50,),
    //                 IconButton(
    //                   iconSize: 35,
    //                   onPressed: () {
    //                     _assetsAudioPlayer.previous();
    //                   },
    //                   icon: Icon(Icons.navigate_before),
    //                 ),
    //                 IconButton(
    //                   icon: Icon(CupertinoIcons.gobackward_30),
    //                   onPressed: () {
    //                     _assetsAudioPlayer.seekBy(Duration(seconds: -30));
    //                   },
    //                   iconSize: 45,
    //                 ),
    //                 StreamBuilder(
    //                   stream: _assetsAudioPlayer.isPlaying,
    //                   initialData: false,
    //                   builder:
    //                       (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //                     return IconButton(
    //                       onPressed: () {
    //                         _assetsAudioPlayer.playOrPause();
    //                       },
    //                       iconSize: 65,
    //                       color: kPrimaryColor,
    //                       icon: Icon(snapshot.data == true
    //                           ? Icons.pause_circle_filled_rounded
    //                           : Icons.play_circle_fill_rounded),
    //                     );
    //                   },
    //                 ),
    //                 IconButton(
    //                   icon: Icon(CupertinoIcons.goforward_30),
    //                   onPressed: () {
    //                     _assetsAudioPlayer.seekBy(Duration(seconds: 30));
    //                   },
    //                   iconSize: 45,
    //                 ),
    //                 IconButton(
    //                   iconSize: 35,
    //                   icon: Icon(Icons.navigate_next),
    //                   onPressed: () {
    //                     _assetsAudioPlayer.next();
    //                   },
    //                 ),
    //               ],
    //             ),
    //             Divider(
    //               height: 5,
    //               thickness: 2,
    //               indent: 15,
    //               endIndent: 15,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(0.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   IconButton(
    //                     icon: Icon(CupertinoIcons.doc_text),
    //                     onPressed: () {
    //                       _onScriptPressed(currentScript);
    //                     },
    //                     iconSize: 30,
    //                   ),
    //                   SizedBox(width: size.width * 0.2),
    //                   IconButton(
    //                     icon: Icon(CupertinoIcons.list_bullet),
    //                     onPressed: () {
    //                       _onTrackPressed();
    //                     },
    //                     iconSize: 30,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             SizedBox(width: 40,),
    //           ],
    //         ),
    //       ),
    //   ),
    // );
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
              child: _buildTrackBottomNavigationMenu(),
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


