import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseAuth _auth=  FirebaseAuth.instance;
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

  Future<String> registerVendor(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxOption,
    String taxNumber,
    Uint8List? image,
  ) async {
    String res = 'Some error occurred';
    try {
      if (businessName.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          countryValue.isNotEmpty &&
          stateValue.isNotEmpty &&
          cityValue.isNotEmpty &&
          taxOption.isNotEmpty &&
          taxNumber.isNotEmpty &&
          image != null) {
        //save data to cloud firestore



      }else{
        res='something went wrong';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
