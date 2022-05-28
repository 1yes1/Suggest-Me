import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'APIData.dart';
import 'AppColors.dart';
import 'main.dart';
import 'GetDataFromAPI.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyAPIPage extends StatefulWidget {
  const MyAPIPage({Key? key}) : super(key: key);

  @override
  State<MyAPIPage> createState() => _MyAPIPageState();
}

class _MyAPIPageState extends State<MyAPIPage> {

  bool changed = false;
  bool isMuted = false;

  late Future<List<APIData>> listFuture;
  // qtRKdVHc-cE

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("API Page"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildBody()
        ],
      ),
    );
  }

  Widget _buildBody() {

    return FutureBuilder<List<APIData>>(
      future: listFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text(snapshot.error.toString()));
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        YoutubePlayerController _controller = YoutubePlayerController(
          initialVideoId: snapshot.data![0].getData.toString(),
          flags: YoutubePlayerFlags(
            mute: false,
            enableCaption: true,
            loop: true,
          ),
        );

        return Container(
            padding: EdgeInsets.all(5),
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors().clrDark,
              progressColors: ProgressBarColors(
                playedColor: appColors.clrRed,
              ),
              bottomActions: [
                CurrentPosition(),
                const SizedBox(width: 10.0),
                ProgressBar(isExpanded: true),
                const SizedBox(width: 10.0),
                RemainingDuration(),
                // IconButton(onPressed: () {
                //
                //   if(!isMuted)
                //     _controller.mute();
                //   else
                //     _controller.unMute();
                //
                //   setState(() {
                //
                //     isMuted = !isMuted;
                //   });
                //
                //   print("Changed Mute: "+isMuted.toString());
                //
                // }, icon: Icon((isMuted == false) ? iconSoundOn : iconSoundOff,color: Colors.white, )),
                FullScreenButton(),
              ],
              ),
              builder: (BuildContext , Widget ) {
                return Widget;
            },
            )
        );

      },
    );
  }


}
