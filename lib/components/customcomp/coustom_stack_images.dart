//
// import 'package:flutter/material.dart';
//
// class CoustomStackImages extends StatelessWidget {
//   int imageCount;
//   double boxSize;
//   List imageList;
//
//   CoustomStackImages({
//     super.key,
//     required this.imageCount,
//     required this.boxSize,
//     required this.imageList,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var containerSize = imageCount + 1;
//
//     if (imageList.isEmpty) {
//       return SizedBox(
//         width: boxSize,
//         height: boxSize,
//         child: const Text("noImage"),
//       );
//     }
//
//     if (imageList.length <= imageCount) {
//       return SizedBox(
//           // color: Colors.blue,
//           width: boxSize,
//           height: boxSize,
//           child: Row(
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   width: boxSize,
//                   height: boxSize,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ImageCard(
//                           image: imageList[index],
//                           imageType: ImageType.Asset,
//                           onTapHandler: () {},
//                           width: boxSize,
//                           height: boxSize,
//                           borderRadius: 12.0);
//                     },
//                     itemCount: imageList.length,
//                   ),
//                 ),
//               ),
//             ],
//           ));
//     }
//
//     var remainingImages = imageList.length - imageCount;
//
//     return Container(
//       // color: Colors.amber,
//       width: boxSize * containerSize +
//           screenWidthPercentage(context, containerSize),
//       height: boxSize,
//       child: Row(
//         children: [
//           Expanded(
//             child: SizedBox(
//                 width: boxSize,
//                 height: boxSize,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ImageCard(
//                         image: imageList[index],
//                         onTapHandler: () {},
//                         width: boxSize,
//                         height: boxSize,
//                         borderRadius: 12.0);
//                   },
//                   itemCount: imageCount,
//                   separatorBuilder: (BuildContext context, int index) {
//                     return const SizedBox(
//                       width: 6,
//                     );
//                   },
//                 )),
//           ),
//           const SizedBox(
//             width: 6,
//           ),
//           SizedBox(
//             width: boxSize,
//             height: boxSize,
//             child: Stack(
//               children: [
//                 ImageCard(
//                     image: imageList[imageCount],
//                     onTapHandler: () {},
//                     width: boxSize,
//                     height: boxSize,
//                     borderRadius: 12.0),
//                 Container(
//                   width: boxSize,
//                   height: boxSize,
//                   decoration: ShapeDecoration(
//                     color: ColorPallet.textBlackColor.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "$remainingImages+",
//                     style: GoogleFonts.lexend(
//                       color: ColorPallet.textWhiteColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
