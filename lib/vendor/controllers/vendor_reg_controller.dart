import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseAuth _auth=  FirebaseAuth.instance;
  final FirebaseFirestore _fireStore=FirebaseFirestore.instance;
  //FUNCTION TO PICK STORE IMAGE
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image is selected');
    }
    //FUNCTION TO PICK STORE IMAGE END HERE
  }
//FUNCTION TO STORE IMAGE TO FIREBASE STORAGE
  _uploadVendorImageToFirestore(Uint8List? image)async{

    Reference ref=_storage.ref().child('storeImages').child(_auth.currentUser!.uid);
    UploadTask uploadTask=ref.putData(image!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadUrl=await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> registerVendor(
      String businessName,
      String email,
      String phoneNumber,
      String countryValue,
      String stateValue,
      String cityValue,
      String taxRegistered,
      String taxNumber,
      Uint8List? image,
      ) async {
    String res = 'something went wrong!';
    try {
      // Check if the user is authenticated before accessing uid
      if (_auth.currentUser != null) {
        String storeImage = await _uploadVendorImageToFirestore(image);

        // Save data to Cloud Firestore
        await _fireStore.collection('vendors').doc(_auth.currentUser!.uid).set({
          'businessName': businessName,
          'email': email,
          'phoneNumber': phoneNumber,
          'countryValue': countryValue,
          'stateValue': stateValue,
          'cityValue': cityValue,
          'taxRegistered': taxRegistered,
          'taxNumber': taxNumber,
          'storeImage': storeImage,
          'approved': false,
        });

        res = 'Registration successful';
      } else {
        res = 'User not authenticated';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

}
