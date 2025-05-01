import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mad_assessment_ba/main.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Editprofilescreen extends StatefulWidget {
  const Editprofilescreen({super.key});

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

class _EditprofilescreenState extends State<Editprofilescreen> {
  String playerName = "Player Name";
  late bool usePlayerName;
  late bool allowedCameraRollPermission = false;
  String imagePath = "images/myProfilePic.jpg";
  File? imageFile;
  @override
  void initState() {
    super.initState();
    usePlayerName = Provider.of<PlayerdetailsProvider>(context, listen: false)
        .usePlayerName;
imagePath = Provider.of<PlayerdetailsProvider>(context, listen: false)
      .profilePicture;
      playerName = Provider.of<PlayerdetailsProvider>(context, listen: false).playerName;
    getImagePath().then((path) {
      if (path != null) {
        setState(() {
          imageFile = File(path);
        });
      }
    });
  }

  Future<void> getCameraRollPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      allowedCameraRollPermission = true;
      launchCameraRollApp();
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Camera permission is required to take a photo')),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
  }

  Future<String?> getImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_image_path');
  }

  Future<void> launchCameraRollApp() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print('Image selected: ${image.path}');
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = '${directory.path}/profile_picture.jpg';

      final File newImage = await File(image.path).copy(newPath);

      // Save the image path
      await saveImagePath(newPath);
      imagePath = newPath;
      setState(() {
        imageFile = newImage;
      });

      print('Image saved to: ${newImage.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: imagePath != 'images/myProfilePic.jpg' &&
                          imagePath.isNotEmpty
                      ? FileImage(File(imagePath))
                      : AssetImage('images/myProfilePic.jpg'),
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          getCameraRollPermission();
                          if (allowedCameraRollPermission) {
                            launchCameraRollApp();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Camera permission is required to take a photo')),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt, size: 30),
                            SizedBox(width: 10),
                            Text("Change Profile Picture",
                                style: TextStyle(
                                  fontSize: 17.5,
                                )),
                          ],
                        ))),
                SizedBox(height: 20),
                TextField(
                    decoration: InputDecoration(
                      labelText: playerName,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      playerName = value;
                    }),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        usePlayerName = !usePlayerName;
                      });
                      ;
                    },
                    child: Row(children: [
                      Text("Set as Default Name",
                          style: TextStyle(
                            fontSize: 17.5,
                          )),
                      Spacer(),
                      Switch(
                        value: usePlayerName,
                        onChanged: (value) {
                          usePlayerName = value;
                        },
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Provider.of<PlayerdetailsProvider>(context, listen: false)
                          .updatePlayerName(playerName);
                      BAScorekeep().updatePlayerName(playerName);
                      Provider.of<PlayerdetailsProvider>(context, listen: false)
                          .updateUsePlayerName(usePlayerName);
                      Provider.of<PlayerdetailsProvider>(context, listen: false)
                          .updateImageFile(imagePath);
                      Navigator.pop(context);
                    },
                    child: Text("Save Changes",
                        style: TextStyle(
                          fontSize: 17.5,
                        )),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Return without making changes",
                        style: TextStyle(
                          fontSize: 17.5,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
