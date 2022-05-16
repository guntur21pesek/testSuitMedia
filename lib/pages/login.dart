import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testsuitmedia/pages/landing_page.dart';
import 'package:testsuitmedia/widget/util.dart';

enum ImageSourceType { gallery, camera }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _namaController = new TextEditingController();
  TextEditingController _palindromeController = new TextEditingController();

  var imagePicker;
  var _image;
  late Image imgFromPref;
  late Future<File> imageFile;

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  Future getImage() async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image!.path) as XFile?;
      Utility.saveImageToPref(Utility.base64String(_image.readAsBytes()));
    });
  }

  loadImageFromPref() {
    Utility.getImageFromPref().then((img) {
      if (null == img) {
        return;
      }
      setState() {
        imgFromPref = Utility.imageFromBase64String(img);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                _Body,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _Body => Expanded(
        child: GestureDetector(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 800.0,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Stack(children: [
                        buildImage(),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: buildEditIcon(),
                        )
                      ]),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _namaController,
                        maxLength: 50,
                        decoration: new InputDecoration(
                          hintText: "Nama",
                          labelText: "Nama",
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _palindromeController,
                        maxLength: 50,
                        decoration: new InputDecoration(
                            hintText: "Palindrome",
                            labelText: "Palindrome",
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildEditIcon() => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
          color: Colors.white,
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black,
            size: 20,
          )));

  Widget buildImage() {
    return ClipOval(
      child: Material(
        child: Container(
          height: 128,
          width: 128,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Center(
              child: _image == null
                  ? Icon(
                      Icons.person,
                      size: 128.0,
                    )
                  : Image.file(
                      _image,
                      width: 128.0,
                      height: 128.0,
                      fit: BoxFit.cover,
                    )),
        ),
      ),
    );
  }

  Widget buildCircle(
          {required Widget child, required double all, required Color color}) =>
      Container(
          padding: EdgeInsets.all(all),
          color: Colors.transparent,
          child: child);

  Widget _buildButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LandingPage();
              }));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              width: double.infinity,
              child: Text(''),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 7, 44, 87),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ),
        ],
      ),
    );
  }
}
