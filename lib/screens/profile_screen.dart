import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour_recommendation_app/screens/favourite_screen.dart';
import 'package:tour_recommendation_app/services/reusable_components.dart';
import 'package:tour_recommendation_app/utils/reusable_components.dart';
import 'package:tour_recommendation_app/utils/tours_details.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

enum Genders {male, female, na}

class _AccountScreenState extends State<AccountScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  late final emailController = TextEditingController(text: user?.email ?? "");
  Genders? _gender;

  @override
  void initState() {
    super.initState();
    nameController.text = userDetails['name'];
    ageController.text = userDetails['age'];
    phoneController.text = userDetails['phone'];
    genderController.text = userDetails['gender'];
    if(userDetails['gender']!=''){
      if(userDetails['gender']=='male'){
        _gender = Genders.male;
      }else{
        _gender = Genders.female;
      }
    }
    print(_gender);
  }

  void _saveUserDetails() async{
    String name = nameController.text.trim();
    String gender = _gender.toString().split('.').last;
    String phone = phoneController.text.trim();
    String age = ageController.text.trim();
    await FirebaseUtils.saveUserDetails(name,gender,phone,age,user!.uid,context);
    final response = await FirebaseUtils.getUserDetails(user!.uid);
    setState(() {
      userDetails = response!;
    });
  }

  void _openEditProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom+20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close))
                ],
              ),
              
              const SizedBox(height: 16),

              SizedBox(
                height: 60,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              RadioGroup<Genders>(
                groupValue: _gender,
                onChanged: (Genders? value) {
                  setModalState(() => _gender = value);
                  setState(() {
                    _gender = value;
                    print("value: $value");
                  });
                  print(_gender);
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Gender: '),
                    SizedBox(
                      width: 140,
                      child: const ListTile(
                        horizontalTitleGap: 0,
                        title: Text('Male'),
                        leading: Radio<Genders>(value: Genders.male),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: const ListTile(
                        horizontalTitleGap: 0,
                        title: Text('Female'),
                        leading: Radio<Genders>(value: Genders.female),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 60,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 60,
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    labelText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 60,
                child: TextField(
                  controller: emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  onPressed: () {
                    _saveUserDetails();
                    Navigator.pop(context);
                  },
                  child: const Text("Save", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ],
          ),
        );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () async{
              // await FirebaseUtils.saveTourDetails();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(UiUtils.getAvatar(userDetails['gender']))
              ),  
            ),
            const SizedBox(height: 12),
            // Name & Email
            Text(
              userDetails['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              userDetails['email'],
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // Edit & Share Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _openEditProfileModal();
                    },
                    icon: const Icon(Icons.edit, size: 18, color: Colors.white,),
                    label: const Text("Edit Profile", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Account Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "ACCOUNT",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            ),
            _buildProfileTile("Wishlist", "Saved destinations", Icons.favorite, context ),

            const SizedBox(height: 16),

            // Preferences Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "PREFERENCES",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            ),
            _buildProfileTile("Settings", "App preferences", Icons.settings, context ),
            _buildProfileTile("Help & Support", "Contact us, FAQs", Icons.help, context ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                UiUtils.showAlertDialog(context, alertHeading: 'Logout Account', alertMessage: 'Are you sure you want to logout from your account?');
              },
              icon: const Icon(Icons.logout),
              label: const Text("Log Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () async{
                UiUtils.showAlertDialog(context, alertHeading: 'Delete Account', alertMessage: "Are you sure you want to delete your account? This action cannot be undone.", buttonText2: 'Yes, Delete');
              },
              icon: const Icon(Icons.person_remove_alt_1),
              label: const Text("Delete Account"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileTile(String title, String subtitle, IconData icon, context){
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if(title == "Wishlist"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
        }else{
          Fluttertoast.showToast(
            timeInSecForIosWeb: 3,
            msg: "Under Development",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
    );
  }
}