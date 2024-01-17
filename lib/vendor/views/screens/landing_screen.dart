import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vendor_app_only/vendor/models/vendors_user_model.dart';
class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference vendorsStream=FirebaseFirestore.instance.collection('vendors');
    const Uuid _uuid=Uuid();
    final String uid=_uuid.v4();
    return  Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: vendorsStream.doc('32c616a2-4b25-4fc1-a59e-32a4616440a1').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
          if(snapshot.hasError){
            return const Text('something went wrong!');

          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text('Loading');
          }
          VendorsUserModel? vendorsUserModel;

          if (snapshot.data != null && snapshot.data!.exists) {
            vendorsUserModel = VendorsUserModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (vendorsUserModel != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      vendorsUserModel.storeImage.toString(),
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 15,),
                Text(
                  vendorsUserModel!.businessName.toString(), // Use null-aware operator
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Your application has been sent to shop admin\nAdmin will get back to you soon ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800,

                  ),
                ),
                const SizedBox(height: 10,),
                TextButton(onPressed: (){},
                    child: const Text('Sign out',
                    style: TextStyle(decoration: TextDecoration.underline),
                    ))

              ],
            ),
          );



        },
         )
    );
  }
}
