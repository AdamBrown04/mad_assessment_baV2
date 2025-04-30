import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/main.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:provider/provider.dart';

class Editprofilescreen extends StatefulWidget {
  const Editprofilescreen({super.key});

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

class _EditprofilescreenState extends State<Editprofilescreen> {
  String playerName = "";
  late bool usePlayerName;
  @override
  void initState() {
    super.initState();
    usePlayerName = Provider.of<PlayerdetailsProvider>(context, listen: false).usePlayerName;
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
                  backgroundImage: AssetImage('images/myProfilePic.jpg'),
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
                        onPressed: () {},
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
                      labelText: 'Player Name',
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
                      });;
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
