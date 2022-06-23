import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:travelbuddies_mobile/config.dart';
import 'package:travelbuddies_mobile/models/edit_user_request_model.dart';
import 'package:travelbuddies_mobile/services/api_service.dart';

class EditAccountPage extends StatefulWidget {
  final int userId;
  final String name;
  final String age;
  final String email;
  final String location;

  EditAccountPage(
      {required this.userId,
      required this.name,
      required this.age,
      required this.email,
      required this.location});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? name;
  String? age;
  String? email;
  String? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add New Plan"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            ProgressHUD(
              inAsyncCall: isApiCallProcess,
              opacity: 0.3,
              key: UniqueKey(),
              child: Form(
                key: globalFormKey,
                child: _editAccountUI(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _editAccountUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormHelper.inputFieldWidget(
            context,
            "name",
            widget.name,
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Destination Name Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              name = onSavedVal;
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
            "email",
            widget.email,
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              email = onSavedVal;
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
            "age",
            widget.age,
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              age = onSavedVal;
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
            "location",
            widget.location,
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              location = onSavedVal;
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
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: FormHelper.submitButton(
              "Done",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = false;
                  });
                  EditUserRequestModel model = EditUserRequestModel(
                    name: name!,
                    age: age!,
                    location: location!,
                    email: email!,
                  );

                  APIService.updateUser(model, widget.userId)
                      .then((response) => {
                            setState(() {
                              isApiCallProcess = false;
                            }),
                            if (response)
                              {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/account', (route) => false),
                              }
                            else
                              {
                                FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "Please fill all form",
                                    "OK", () {
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
