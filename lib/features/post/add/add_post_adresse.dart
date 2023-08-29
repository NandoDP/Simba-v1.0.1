// ignore_for_file: must_be_immutable

import 'dart:async';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:simba/models/post_model.dart';

class AddPostAdresse extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  // Post poste;
  // File? bannerFile;
  AddPostAdresse({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPostAdresseState();
}

class _AddPostAdresseState extends State<AddPostAdresse> {
  late TextEditingController textEditingController = TextEditingController();
  late PickerMapController controller = PickerMapController(
    initPosition: GeoPoint(
      latitude: 14.7221049,
      longitude: -17.4519334,
    ),
  );

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(textOnChanged);
  }

  void textOnChanged() {
    controller.setSearchableText(textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.removeListener(textOnChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.searchableText.value);
    // print(controller.);
    if (textEditingController.text.isNotEmpty &&
        controller.searchableText.value != textEditingController.text) {
      textEditingController.text = controller.searchableText.value;
    }
    return CustomPickerLocation(
      controller: controller,
      topWidgetPicker: Padding(
        padding: const EdgeInsets.only(
          top: 56,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                PointerInterceptor(
                  child: TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close),
                  ),
                ),
                Expanded(
                  child: PointerInterceptor(
                    child: TextField(
                      controller: textEditingController,
                      onEditingComplete: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffix: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: textEditingController,
                          builder: (ctx, text, child) {
                            if (text.text.isNotEmpty) {
                              return child!;
                            }
                            return const SizedBox.shrink();
                          },
                          child: InkWell(
                            focusNode: FocusNode(),
                            onTap: () {
                              textEditingController.clear();
                              controller.setSearchableText("");
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        focusColor: Colors.black,
                        filled: true,
                        hintText: "search",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.white,
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            TopSearchWidget()
          ],
        ),
      ),
      bottomWidgetPicker: Positioned(
        bottom: 12,
        right: 8,
        child: PointerInterceptor(
          child: FloatingActionButton(
            onPressed: () async {
              // GeoPoint p = await controller.selectAdvancedPositionPicker();
              // // Navigator.pop(context, p);
              // setState(() {
              //   widget.poste.adresse = textEditingController.text;
              //   // widget.poste.adresse = controller.searchableText.value;
              //   widget.poste.adresseMap = AdresseMap(
              //     latitude: p.latitude,
              //     longitude: p.longitude,
              //   );
              // });
              // print(widget.poste);
              // ref.read(postControllerProvider.notifier).sharePost(
              //       context: context,
              //       post: widget.poste,
              //       file: widget.bannerFile,
              //     );
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
      pickerConfig: const CustomPickerLocationConfig(
        zoomOption: ZoomOption(
          initZoom: 15,
        ),
      ),
    );
  }
}

class TopSearchWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopSearchWidgetState();
}

class _TopSearchWidgetState extends State<TopSearchWidget> {
  late PickerMapController searchController;
  ValueNotifier<GeoPoint?> notifierGeoPoint = ValueNotifier(null);
  ValueNotifier<bool> notifierAutoCompletion = ValueNotifier(false);

  late StreamController<List<SearchInfo>> streamSuggestion = StreamController();
  late Future<List<SearchInfo>> _futureSuggestionAddress;
  String oldText = "";
  Timer? _timerToStartSuggestionReq;
  final Key streamKey = const Key("streamAddressSug");

  @override
  void initState() {
    super.initState();
    searchController = CustomPickerLocation.of(context);
    searchController.searchableText.addListener(onSearchableTextChanged);
  }

  void onSearchableTextChanged() async {
    final v = searchController.searchableText.value;
    if (v.length > 3 && oldText != v) {
      oldText = v;
      if (_timerToStartSuggestionReq != null &&
          _timerToStartSuggestionReq!.isActive) {
        _timerToStartSuggestionReq!.cancel();
      }
      _timerToStartSuggestionReq =
          Timer.periodic(const Duration(seconds: 3), (timer) async {
        await suggestionProcessing(v);
        timer.cancel();
      });
    }
    if (v.isEmpty) {
      await reInitStream();
    }
  }

  Future reInitStream() async {
    notifierAutoCompletion.value = false;
    await streamSuggestion.close();
    setState(() {
      streamSuggestion = StreamController();
    });
  }

  Future<void> suggestionProcessing(String addr) async {
    notifierAutoCompletion.value = true;
    _futureSuggestionAddress = addressSuggestion(
      addr,
      limitInformation: 5,
    );
    _futureSuggestionAddress.then((value) {
      streamSuggestion.sink.add(value);
    });
  }

  @override
  void dispose() {
    searchController.searchableText.removeListener(onSearchableTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifierAutoCompletion,
      builder: (ctx, isVisible, child) {
        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          height: isVisible ? MediaQuery.of(context).size.height / 4 : 0,
          child: Card(
            child: child!,
          ),
        );
      },
      child: StreamBuilder<List<SearchInfo>>(
        stream: streamSuggestion.stream,
        key: streamKey,
        builder: (ctx, snap) {
          if (snap.hasData) {
            return ListView.builder(
              itemExtent: 50.0,
              itemBuilder: (ctx, index) {
                return PointerInterceptor(
                  child: ListTile(
                    title: Text(
                      snap.data![index].address.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    onTap: () async {
                      setState(() {
                        searchController.setSearchableText(
                          snap.data![index].address.toString(),
                        );
                      });
                      // print(snap.data![index].address.toString());
                      // print(searchController.searchableText.value);

                      /// go to location selected by address
                      searchController.goToLocation(
                        snap.data![index].point!,
                      );

                      /// hide suggestion card
                      notifierAutoCompletion.value = false;
                      await reInitStream();
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );
                    },
                  ),
                );
              },
              itemCount: snap.data!.length,
            );
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const Card(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
