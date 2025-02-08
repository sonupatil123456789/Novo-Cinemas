import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/dartassets/novoHeaderLogo.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MallInformation extends StatelessWidget {
  final String mallName;
  final double latitude;
  final double longitude;
  const MallInformation(
      {super.key,
      required this.mallName,
      required this.latitude,
      required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mallName,
          style: context.textThemeDecoration.titleMedium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: context.colorPalette.accentColor,
          ),
        ),
        SizedBox(height: context.getScreenHeight(3)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorPalette.accentColor.withOpacity(.5),
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Novo Cinemas Logo
              SvgPicture.string(
                novoHeaderLogo(context),
                width: context.getScreenWidth(20),
                height: context.getScreenHeight(8),
              ),
              SizedBox(height: context.getScreenHeight(4)),

              // Parking & Booking Options
              MallFeature(
                asset: 'assets/svgassets/parking.svg',
                title: "VALET PARKING",
                context: context,
              ),
              SizedBox(
                height: context.getScreenHeight(1),
              ),
              Divider(
                color: context.colorPalette.accentColor.withOpacity(.20),
              ),
              MallFeature(
                asset: 'assets/svgassets/privatebooking.svg',
                title: "PRIVATE BOOKING",
                context: context,
              ),

              SizedBox(
                height: context.getScreenHeight(1),
              ),
              Divider(
                color: context.colorPalette.accentColor.withOpacity(.20),
              ),
              MallFeature(
                asset: 'assets/svgassets/freeparking.svg',
                title: "FREE PARKING",
                context: context,
              ),
              SizedBox(
                height: context.getScreenHeight(1),
              ),
              Divider(
                color: context.colorPalette.accentColor.withOpacity(.20),
              ),
              MallFeature(
                asset: 'assets/svgassets/birthday.svg',
                title: "BIRTHDAY CELEBRATION BOOKING",
                context: context,
              ),

              const SizedBox(height: 20),

              // Embedded Google Map
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    height: 150,
                    child: FlutterMap(
                      options: MapOptions(),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80,
                              height: 80,
                              point: LatLng(latitude, longitude),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.red,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.getScreenHeight(3),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colorPalette.accentColor,
            border: Border.all(
              color: context.colorPalette.accentColor.withOpacity(.20),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            "Call us on toll free number : +111 3454 4543 345",
            style: context.textThemeDecoration.paragraphMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: context.colorPalette.blackColor,
            ),
          ),
        ),
        SizedBox(
          height: context.getScreenHeight(6),
        ),
      ],
    );
  }
}

class MallFeature extends StatelessWidget {
  final String asset;
  final String title;
  final BuildContext context;
  const MallFeature({
    super.key,
    required this.asset,
    required this.title,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(asset),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textThemeDecoration.titleMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.colorPalette.accentColor,
                      ),
                    ),
                    Text(
                      "Enjoy hassle-free valet parking for your visit",
                      style:
                          context.textThemeDecoration.paragraphMedium.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: context.colorPalette.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
