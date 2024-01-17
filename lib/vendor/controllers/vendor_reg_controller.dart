import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  // FUNCTION TO PICK STORE IMAGE
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image is selected');
    }
    // FUNCTION TO PICK STORE IMAGE END HERE
  }

  // FUNCTION TO STORE IMAGE TO FIREBASE STORAGE
  _uploadVendorImageToFirestore(Uint8List? image) async {
    String uuid = _uuid.v4();
    Reference ref = _storage.ref().child('storeImages').child(uuid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get download URL without the token
    String downloadUrl = await ref.getDownloadURL();

    print('Download URL: $downloadUrl'); // Add this line for debugging
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
    String uuid = _uuid.v4();
    try {
      String storeImage = await _uploadVendorImageToFirestore(image);

      // Save data to Cloud Firestore with the same UUID
      await _fireStore.collection('vendors').doc(uuid).set({
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
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
