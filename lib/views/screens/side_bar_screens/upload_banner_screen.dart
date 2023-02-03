import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_vendor_admin/views/screens/side_bar_screens/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '/upload-banner';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic _image;


  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;

        fileName = result.files.first.name;
      });
    }
  }

  _uploadBannersToStorage(dynamic image) async{
      Reference ref =  _storage.ref().child('Banners').child(fileName!);

      UploadTask uploadTask =  ref.putData(image);

     TaskSnapshot snapshot =   await uploadTask;

     String downloadUrl = await  snapshot.ref.getDownloadURL();

     return downloadUrl;
  }


  _uploadBannersToFirestore() async{
    EasyLoading.show();
    if(_image!=null){
     String imageUrl = await  _uploadBannersToStorage(_image);

     await _firestore.collection('banners').doc(fileName).set({
       'image':imageUrl,
     }).whenComplete(() {
       EasyLoading.dismiss();
       setState(() {
         _image = null;
       });
     });

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Upload Banner',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                //image box

                Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                _image,
                                fit: BoxFit.cover,
                              ))
                          : const Center(
                              child: Text(
                                "Upload",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow.shade900,
                        ),
                        onPressed: () {
                          pickImage();
                        },
                        child: const Text(
                          "Upload Image",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),

                const SizedBox(
                  width: 30,
                ),

                //save button

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow.shade900,
                    ),
                    onPressed: () {
                      _uploadBannersToFirestore();
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),

          const SizedBox(
            width: 30,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:const  Text(
                "BANNERS",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          BannerWidget()
        ],
      ),
    );
  }
}
