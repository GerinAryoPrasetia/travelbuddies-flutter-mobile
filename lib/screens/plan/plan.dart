import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:travelbuddies_mobile/config.dart';
import 'package:travelbuddies_mobile/models/plan_response.dart';
import 'package:travelbuddies_mobile/screens/plan/add_plan.dart';
import 'package:travelbuddies_mobile/services/api_service.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  bool apiCallProcess = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Plan"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          FutureBuilder<List<PlanResponseModel>>(
            future: APIService.getUserPlan(),
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                List<PlanResponseModel> planData = snapshot.requireData;
                print(planData);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: planData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        planData[index].destinationName!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        planData[index].schedule!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Center(
                                        child: FormHelper.submitButton(
                                          "Delete",
                                          // width: 100.0,
                                          // height: 30.0,
                                          fontSize: 12.0,
                                          () {
                                            APIService.deletePlan(
                                                    planData[index].id!)
                                                .then((value) => {
                                                      setState(() {
                                                        apiCallProcess = false;
                                                      }),
                                                      if (value)
                                                        {
                                                          {
                                                            Navigator
                                                                .pushNamedAndRemoveUntil(
                                                                    context,
                                                                    '/',
                                                                    (route) =>
                                                                        false),
                                                          }
                                                        }
                                                      else
                                                        {
                                                          FormHelper
                                                              .showSimpleAlertDialog(
                                                                  context,
                                                                  Config
                                                                      .appName,
                                                                  "Gagal",
                                                                  "OK", () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                        }
                                                    });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          );
                        },
                      ),
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPlanPage(),
                              ),
                            );
                          },
                          child: const Text('Add New Plan'),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/no_data.png',
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      "Sorry, you don't have any plan right now.\nLet's add new plan for your holiday!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPlanPage(),
                            ),
                          );
                        },
                        child: const Text('Add New Plan'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
