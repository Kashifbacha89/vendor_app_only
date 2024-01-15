import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app_only/vendor/controllers/vendor_reg_controller.dart';
class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  final VendorController _vendorController=VendorController();
  late String countryValue;
  late String stateValue;
  late String cityValue;
  Uint8List? _image;
  selectGalleryImage()async{
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
  }
  //tax options
  String? _taxStatus;
  List<String> taxOptions=[
    'YES',
    'NO'
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context,constraints){
              return FlexibleSpaceBar(
                background: Container(
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow.shade900,
                        Colors.yellow
                      ]
                    )
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _image !=null?Image.memory(_image!):IconButton(
                            onPressed: (){
                              selectGalleryImage();

                            },
                            icon: const Icon(CupertinoIcons.photo),),
                        )
                      ],
                    ),
                  ),
                ),
              );

            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Business Name'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectState(
                        onCountryChanged: (value){
                          setState(() {
                            countryValue=value;
                          });
                        },
                        onStateChanged: (value){
                          setState(() {
                            stateValue=value;
                          });
                        },
                        onCityChanged: (value){
                          setState(() {
                            cityValue=value;

                          });
                        }),
                  ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tax Registered',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      Flexible(

                        child: SizedBox(
                          width: 100,
                          child: DropdownButtonFormField(
                              hint: const Text('select'),
                              items: taxOptions.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child:Text(value) );
                          }).toList(), onChanged: (value){
                            setState(() {
                              _taxStatus=value;

                            });
                          }),
                        ),
                      ),

                    ],
                  ),
                  if(_taxStatus=='YES')
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tax number'
                        ),
                      ),
                    ),
                  const SizedBox(height: 40,),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      width: MediaQuery.sizeOf(context).width-40,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child:  Text('SAVE',style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],

      ),
    );
  }
}

