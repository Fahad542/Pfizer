import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfizer/src/services/remote/api_service.dart';
import 'package:pfizer/src/shared/top_app_bar.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:pfizer/src/views/Tagging/tagging_view.dart';
import 'package:pfizer/src/views/Tagging/tagging_view_model.dart';
import 'package:provider/provider.dart';

import '../../base/utils/Constants.dart';
import '../dashboard/dashboard_view_model.dart';

class GeoTAgUpdate extends StatefulWidget {
  final String Hospitalname;
  final String custlat;
  final String custlong;
  final String address;
  final int index;
  final String hospitalid;

  //List<Tagging> searchResults = [];

  const GeoTAgUpdate(
      {Key? key,
      required this.address,
      required this.custlat,
      required this.custlong,
      required this.index,
      required this.Hospitalname,
      required this.hospitalid,

      })
      : super(key: key);

  @override
  State<GeoTAgUpdate> createState() => _GeoTAgUpdateState();
}

class _GeoTAgUpdateState extends State<GeoTAgUpdate> {
  var isloading = false;
  var _imageFile;
  String imagepath = "";
  ImagePicker picker = ImagePicker();
  String imagelat = "";
  String imagelong = "";

  getImageCamera() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      imagelat = position.latitude.toString();
      imagelong = position.longitude.toString();
    });
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          imagepath = '${pickedFile.path}';
        });
        print('Image Name${pickedFile.path}');
      } else {
        print("no image selected");
      }
    });
  }

  buidProfile() {
    if (_imageFile != null) {
      return Container(
        child: Image.file(
          _imageFile,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        height: 150.0,
        width: 180.0,
        // child: Image.asset(
        //   'assets/premier.png',
        //   height: 150.0,
        //   width: 180.0,
        //   fit: BoxFit.cover,
        // ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
          title: "Update Geo Tag",
          onBackTap: () {
            Navigator.pop(context);
          }),
      body: isloading == false
          ? SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  // offset: Offset(0,
                                  //     3), // changes position of shadow
                                ),
                              ]),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Hospital Name:",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          "${widget.Hospitalname.trim()}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Hospital Address:",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          "${widget.address.trim()}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Current Lat:",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          "${widget.custlat}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Current Long:",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          "${widget.custlong}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: 500,
                        height: 70,

                        child: Center(
                          child: SizedBox(
                            child: InkWell(
                              onTap: () {
                                getImageCamera();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.red),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.green,
                                ),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  "Take a Photo",
                                  textAlign: TextAlign.center,
                                  style: TextStyling.mediumBold
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      imagepath == ""
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        // offset: Offset(0,
                                        //     3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Image Lat:",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Text(
                                                "${imagelat}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Image Long:",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Text(
                                                "${imagelong}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      imagepath == ""
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              child: Container(
                                child: buidProfile(),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      bottomNavigationBar: imagepath == ""
          ? Container(
              height: 10,
            )
          : Container(
              height: 45,
              child: AppBar(
                title: Center(
                  child: Column(
                    children: [
              Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: 45,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  isloading = true;
                                });
                                var i = await ApiService().UploadgeoTag(
                                    this.context,
                                    '${widget.hospitalid}',
                                    '${widget.custlat}',
                                    '${widget.custlong}',
                                    '${imagelat}',
                                    '${imagelong}',
                                    imagepath);

                                Map jsonData = json.decode(i) as Map;
                                String status = jsonData['status'].toString();
                                String msg =
                                    jsonData['status_message'].toString();
                                if (status == "200")  {

                                  final DashboardViewModel dashboardViewModel = DashboardViewModel();
                                  await dashboardViewModel.getTaggingList(context);
                                  //taggingViewModel.deleteItemFromList();
                                  // MyScheduleCard(
                                  //   data: ,
                                  // );

                                  // Delete the item from the list using the index

                                  //print(widget.index);


                                  Navigator.pop(context);
                                  Constants.customSuccessSnack(
                                      context, "${msg}");
                                  setState(() {
                                    isloading = false;
                                    print(status);
                                  });
                                }

                                else {
                                  Navigator.pop(context);
                                  Constants.customErrorSnack(context, "${msg}");
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.red,
                                ),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  "Upload Data",
                                  style: TextStyling.mediumBold
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //title: Text('Products: ${snapshot.data.length.toString()}                   Amount: ${widget.trs}',textAlign: TextAlign.right,style: TextStyle(color:Colors.white,fontSize: 17,fontWeight: FontWeight.bold ),),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primary,
              ),
            ),
    );
  }
}
