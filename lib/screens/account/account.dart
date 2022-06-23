import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelbuddies_mobile/models/user_response_model.dart';
import 'package:travelbuddies_mobile/screens/account/edit_account.dart';
import 'package:travelbuddies_mobile/services/api_service.dart';
import 'package:travelbuddies_mobile/services/shared_services.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/profileicon.png',
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            FutureBuilder<UserResponseModel>(
              future: APIService.getUserProfile(),
              builder: (BuildContext context,
                  AsyncSnapshot<UserResponseModel> model) {
                if (model.hasData) {
                  print(model.data!.name);
                  // return Text(
                  //   "Hi!, ${model.data!.name}",
                  //   style:
                  //       TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  // );
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .65,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text("Name : "),
                              Text(model.data!.name),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .65,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text("Email : "),
                              Text(model.data!.email),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .65,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text("Age : "),
                              Text(model.data!.age),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .65,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text("Location : "),
                              Text(model.data!.location),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 28.0,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          primary: Colors.white,
                          fixedSize: const Size(160, 50),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAccountPage(
                                userId: model.data!.id,
                                name: model.data!.name,
                                age: model.data!.age,
                                location: model.data!.location,
                                email: model.data!.email,
                              ),
                            ),
                          );
                        },
                        child: const Text("Edit Profile"),
                      ),
                    ],
                  );
                }
                return const Text("Please Login");
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.red,
                fixedSize: const Size(160, 50),
              ),
              onPressed: () {
                SharedServices.logout(context);
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      )),
    );
  }
}
