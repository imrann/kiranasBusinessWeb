import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kiranas_business_web/CommonScreens/AppBarCommon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:kiranas_business_web/CommonScreens/SlideRightRoute.dart';
import 'package:kiranas_business_web/CustomWidgets/AddProduct.dart';
import 'package:kiranas_business_web/CustomWidgets/CropImage.dart';

import 'dart:html' as html;

import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'dart:ui' as ui;

class ImageProcessing extends StatefulWidget {
  final html.File uploadedFilePreview;
  final void Function(html.File) capturedImageFile;
  ImageProcessing({this.uploadedFilePreview, this.capturedImageFile});
  @override
  _ImageProcessingState createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  html.File _cloudFile;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// Select an image via gallery
  Future<void> _pickImage(BuildContext context) async {
    final mediaData = await ImagePickerWeb.getImage(outputType: ImageType.file);

    if (true) {
      setState(() {
        _cloudFile = mediaData;
      });

      // Navigator.push(
      //     context,
      //     SlideRightRoute(
      //         widget: CropImage(
      //           selectedImage: _imageWidget,
      //           capturedImageFile: (s) {
      //             setState(() {
      //               finaImage = s;
      //             });
      //             return null;
      //           },
      //         ),
      //         slideAction: "horizontal"));
    } //
  }

  /// Remove image
  void _clear() {
    setState(() {
      _cloudFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: new AppBarCommon(
        title: Text("Product Image"),
        centerTile: false,
        context: context,
        notificationCount: Text("i"),
        isTabBar: false,
        searchOwner: "ProductSearch",
      ),
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () async {
                  _pickImage(context);
                }),
          ],
        ),
      ),

      // Preview the image and crop it
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            if (_cloudFile != null) ...[
              // Center(
              //   child: Container(
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(10),
              //       child: _imageWidget,

              //       // Image.asset(
              //       //   "$showImageFile",
              //       //   // height: _width * 0.34,
              //       //   // width: _width,
              //       //   alignment: Alignment.center,
              //       //   // fit: BoxFit.fitWidth,
              //       // )
              //     ),
              //   ),
              // ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _cloudFile.name +
                            "\n" +
                            (((_cloudFile.size / 1024).ceil()) > 1023
                                ? (_cloudFile.size / (1024 * 1024))
                                        .ceil()
                                        .toString() +
                                    "MB"
                                : (_cloudFile.size / 1024).ceil().toString() +
                                    "KB"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        splashColor: Colors.grey,
                        textColor: Colors.white,
                        color: Colors.pink[900],
                        child: Text("RESET"),
                        onPressed: _clear,
                      ),
                      FlatButton(
                          splashColor: Colors.grey,
                          color: Colors.pink[900],
                          textColor: Colors.white,
                          child: Text("UPLOAD"),
                          onPressed: () async {
                            // var byteData = await _imageWidget.toByteData(
                            //     format: ui.ImageByteFormat.rawRgba);
                            // var buffer = byteData.buffer.asUint8List();
                            // String mimeType =
                            //     mime(Path.basename(mediaData.fileName));
                            // print(mimeType);
                            // html.File dd = new html.File(
                            //     buffer, mediaData.fileName, {'type': mimeType});
                            uploadFile(context, _cloudFile);
                          }),
                    ],
                  ),
                ),
              ),

              // Uploader(file: _imageFile)
            ] else ...[
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[300],
                      size: 300,
                    )),
              ),
              Text(
                "Plese select image",
                textAlign: TextAlign.center,
              )
            ]
          ],
        ),
      ),
    );
  }

  Future uploadFile(BuildContext context, html.File img) async {
    // String name = img.name.toString();
    // firebase_storage.Reference storageReference =
    //     firebase_storage.FirebaseStorage.instance.ref().child('Products/$name');

    // firebase_storage.UploadTask uploadTask = storageReference.putBlob(img);
    // await uploadTask;
    // Fluttertoast.showToast(
    //     gravity: ToastGravity.CENTER,
    //     msg: "File Uploaded",
    //     fontSize: 10,
    //     backgroundColor: Colors.black);
    // storageReference.getDownloadURL().then((fileURL) {
    //   print(fileURL);
    // });

    widget.capturedImageFile(img);

    Navigator.of(context).pop();
  }
}
