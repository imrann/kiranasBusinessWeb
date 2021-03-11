import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiranas_business_web/CommonScreens/AppBarCommon.dart';
import 'package:kiranas_business_web/CustomWidgets/AddProduct.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path/path.dart';

typedef capturedImageFile = String Function(String);

class ImageProcessing extends StatefulWidget {
  final File uploadedFilePreview;
  ImageProcessing({this.uploadedFilePreview});
  @override
  _ImageProcessingState createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  Image image;
  File uplaodfinalImage;
  String showImageFile = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// Cropper plugin
  // Future<void> _cropImage() async {

  //   setState(() {
  //     _imageFile = cropped.path ?? _imageFile;
  //   });
  // }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source,
      {BuildContext context, capturedImageFile}) async {
    final ImagePicker picker = ImagePicker();
    final selected = await picker.getImage(source: source);

    File cropped = await ImageCropper.cropImage(
        sourcePath: selected.path,
        aspectRatioPresets: const [CropAspectRatioPreset.square],
        compressQuality: 100,
        maxHeight: 300,
        maxWidth: 500,
        // ratioX: 1.0,
        // ratioY: 1.0,
        // maxWidth: 512,
        // maxHeight: 512,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'CROP IMAGE'));

    //  cropped != null ? capturedImageFile(cropped.path) : capturedImageFile("");
    capturedImageFile(cropped.path);
    setState(() {
      uplaodfinalImage = cropped;
    });
  }

  /// Remove image
  void _clear() {
    setState(() {
      showImageFile = "";
      image = null;
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
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                _pickImage(
                  ImageSource.camera,
                  context: context,
                  capturedImageFile: (s) {
                    setState(() {
                      showImageFile = s;
                    });
                  },
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () async {
                  final _image = await FlutterWebImagePicker.getImage;
                  setState(() {
                    image = _image;
                  });
                }

                // _pickImage(
                //   ImageSource.gallery,
                //   context: context,
                //   capturedImageFile: (s) {
                //     setState(() {
                //       showImageFile = s;
                //     });
                //   },
                // ),
                ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (showImageFile.isNotEmpty ||
              showImageFile != "" ||
              image != null) ...[
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), child: image
                  // Image.asset(
                  //   "$showImageFile",
                  //   // height: _width * 0.34,
                  //   // width: _width,
                  //   alignment: Alignment.center,
                  //   // fit: BoxFit.fitWidth,
                  // )
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
                FlatButton(
                    child: Icon(Icons.check),
                    onPressed: () {
                      uploadFile(context);
                    }),
              ],
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
              "Plese Select/ capture image.",
              textAlign: TextAlign.center,
            )
          ]
        ],
      ),
    );
  }

  Future uploadFile(BuildContext context) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('Products/${basename(uplaodfinalImage.path)}');

    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(uplaodfinalImage);
    await uploadTask;
    Fluttertoast.showToast(
        msg: "File Uploaded", fontSize: 10, backgroundColor: Colors.black);
    storageReference.getDownloadURL().then((fileURL) {
      print(fileURL);
      // setState(() {
      //   _uploadedFileURL = fileURL;
      // });
    });
    setState(() {
      uploadedFile = uplaodfinalImage;
    });
    Navigator.of(context).pop();
  }
}
