import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cookley/core/button.dart';

class UploadImage extends StatefulWidget {
  UploadImage({
    required this.onChange,
    this.name,
    this.value,
    super.key,
  });

  void Function({String value, String? name, File? file}) onChange;
  String? name;
  String? value;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String? _photo;
  String? img;

  @override
  void initState() {
    super.initState();
    _photo = widget.value;
  }

  @override
  void dispose() {
    _photo = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void openSheet() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          Future<void> getImage(ImageSource source) async {
            final ImagePicker picker = ImagePicker();
            Navigator.pop(context);
            try {
              bool isGranted = false;
              if (source == ImageSource.camera) {
                isGranted = await Permission.camera.request().isGranted;
              } else if (source == ImageSource.gallery) {
                isGranted = await Permission.photos.request().isGranted;
              }

              if (isGranted) {
                final XFile? image = await picker.pickImage(
                    source: source, maxWidth: 420, maxHeight: 660);

                if (image != null) {
                  setState(() {
                    List<int> imageBytes = File(image.path).readAsBytesSync();
                    String base64Image = base64Encode(imageBytes);
                    _photo = base64Image;

                    widget.onChange(
                        value: base64Image,
                        name: widget.name,
                        file: File(image.path));
                  });
                }
              }
            } catch (e) {
              print(e);
            }
          }

          return Container(
            height: 140,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                )),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Button(
                    onPress: () {
                      getImage(ImageSource.gallery);
                    },
                    variant: Variant.primary,
                    label: 'Pick from galery',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Button(
                    onPress: () {
                      getImage(ImageSource.camera);
                    },
                    variant: Variant.secondary,
                    label: 'Pick from camera',
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: openSheet,
      child: Center(
        child: Column(
          children: [
            Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: const Color.fromRGBO(196, 196, 196, 1)),
                child: Center(
                  child: _photo == null
                      ? const Text(
                          'D',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : _photo!.startsWith('http')
                          ? Image.network(
                              _photo!,
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Image.memory(
                              fit: BoxFit.fill,
                              base64Decode(_photo!),
                              height: double.infinity,
                              width: double.infinity,
                            ),
                )),
          ],
        ),
      ),
    );
  }
}
