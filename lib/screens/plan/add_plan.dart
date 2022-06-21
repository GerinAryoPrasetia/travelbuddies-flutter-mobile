import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:travelbuddies_mobile/config.dart';
import 'package:travelbuddies_mobile/models/login_request_model.dart';
import 'package:travelbuddies_mobile/models/add_plan_request_model.dart';
import 'package:travelbuddies_mobile/services/api_service.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({Key? key}) : super(key: key);

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? destinationName;
  String? schedule;
  String? people;
  String? items;
  String? transportation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Add New Plan",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            ProgressHUD(
              inAsyncCall: isApiCallProcess,
              opacity: 0.3,
              key: UniqueKey(),
              child: Form(
                key: globalFormKey,
                child: _addPlanUI(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addPlanUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormHelper.inputFieldWidget(
            context,
            "destinationName",
            "Destination Name",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Destination Name Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              destinationName = onSavedVal;
            },
            prefixIcon: const Icon(Icons.place),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 15.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "schedule",
            "Schedule",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              schedule = onSavedVal;
            },
            prefixIcon: const Icon(Icons.schedule),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 20.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "items",
            "Items",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              items = onSavedVal;
            },
            prefixIcon: const Icon(Icons.backpack),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 20.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "people",
            "People",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              people = onSavedVal;
            },
            prefixIcon: const Icon(Icons.person),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 20.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "transportation",
            "Transportation",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              transportation = onSavedVal;
            },
            prefixIcon: const Icon(Icons.train),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: FormHelper.submitButton(
              "Add Plan",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = false;
                  });
                  PlanRequestModel model = PlanRequestModel(
                    destinationName: destinationName!,
                    people: people!,
                    items: items!,
                    schedule: schedule!,
                    transportation: transportation!,
                  );

                  APIService.addPlan(model).then((response) => {
                        setState(() {
                          isApiCallProcess = false;
                        }),
                        if (response.data != null)
                          {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false),
                          }
                        else
                          {
                            FormHelper.showSimpleAlertDialog(
                                context, Config.appName, "Invalid Data", "OK",
                                () {
                              Navigator.pop(context);
                            })
                          }
                      });
                }
              },
              btnColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              txtColor: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
