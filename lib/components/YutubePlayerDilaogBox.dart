import 'package:flutter/material.dart';
import 'package:novocinema/components/AppBarSection.dart';
import 'package:novocinema/core/theams/Utils.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YutubePlayerDialogBox extends StatelessWidget {
  final String? trailerUrl;
  final String? title ;

  const YutubePlayerDialogBox({super.key , this.title, this.trailerUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        content: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
            // gradient: context.colorPalette.accentColor,
            //here
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 180,
                      height: 16,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          title ?? "",
                          style: context.textThemeDecoration.subTitleSmall.copyWith(
                            fontSize: 5,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ),
                  ),
                   CloseButton(
                    color: context.colorPalette.whiteColor
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: YoutubePlayer(
                    controller: YoutubePlayerController.fromVideoId(
                      videoId: YoutubePlayerController.convertUrlToId(trailerUrl ?? "") ??"",
                      autoPlay: true,
                      params: const YoutubePlayerParams(
                        showControls: true,
                        mute: false,
                        showVideoAnnotations: false,
                        showFullscreenButton: false,
                        loop: false,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
