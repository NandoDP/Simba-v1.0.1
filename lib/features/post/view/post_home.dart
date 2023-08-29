// ignore_for_file: must_be_immutable

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:simba/features/core/utils.dart';
import 'package:simba/models/post_model.dart';

class PostHome extends StatefulWidget {
  Post post;
  PostHome({
    super.key,
    required this.post,
  });

  @override
  State<PostHome> createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {
  Event buildEvent({Recurrence? recurrence}) {
    DateTime date = DateTime(
      widget.post.date.year,
      widget.post.date.month,
      widget.post.date.day,
      int.parse(widget.post.heure.split(' ')[0].split(':')[0]),
      int.parse(widget.post.heure.split(' ')[0].split(':')[1]),
    );
    // debugPrint('OK');
    return Event(
      title: widget.post.title,
      description: widget.post.description ?? '',
      location: widget.post.adresse,
      startDate: date,
      endDate: date.add(const Duration(hours: 2)),
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://example.com",
      ),
      androidParams: const AndroidParams(
        emailInvites: ["test@example.com"],
      ),
      recurrence: recurrence,
    );
  }

  openMapsSheet(context) async {
    try {
      final coords = Coords(
          widget.post.adresseMap.latitude, widget.post.adresseMap.longitude);
      final title = widget.post.adresse;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var post = widget.post;
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      children: [
        if (post.description != null)
          Text(
            post.description!,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Card(
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.access_time,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${post.date.day.toString().padLeft(2, '0')} ${monthInLetter(post.date.month)} ${post.date.year}',
                      style: textTheme.bodySmall!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.64),
                      ),
                    ),
                    Text(post.heure),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  height: 35,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      post.adresse,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () => openMapsSheet(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.add_location_alt,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
