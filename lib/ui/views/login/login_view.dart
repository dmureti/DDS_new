import 'package:distributor/ui/shared/text_styles.dart';
import 'package:distributor/ui/shared/widgets.dart';
import 'package:distributor/ui/views/login/login_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/remember_me/remember_me_checkbox.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'login.i18n.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: model.environments.length > 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        onChanged: (AppEnv val) {
                          model.updateEnv(val);
                        },
                        value: model.appEnv,
                        items: model.environments
                            .map((e) => DropdownMenuItem(
                                  child: Text(
                                    e.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: e,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
        resizeToAvoidBottomPadding: true,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        colorFilter: ColorFilter.srgbToLinearGamma(),
                        image: AssetImage(
                            'assets/images/aromatic-board-bread-breakfast.jpg'),
                        fit: BoxFit.fitHeight)),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UIHelper.verticalSpace(20),
                    LoginTextField(
                      text: 'SIGN IN',
                    ),
                    TextFormFieldPadding(
                      child: TextFormField(
                        autofocus: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                        onChanged: (String val) => model.updateEmail(val),
                        validator: (String value) {
                          if (value != null &&
                              !EmailValidator.validate(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Your email address',
                          hintStyle: TextStyle(fontWeight: FontWeight.w600),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    model.emailValidationMessage == null
                        ? Container()
                        : FormErrorContainer(
                            errorMsg: model.emailValidationMessage,
                          ),
                    TextFormFieldPadding(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a password";
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                        onChanged: (String val) => model.updatePassword(val),
                        keyboardType: TextInputType.text,
                        obscureText: model.obscurePassword,
                        decoration: InputDecoration(
                          hintText: '*****',
                          hintStyle: TextStyle(fontWeight: FontWeight.w600),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: model.toggleObscurePassword,
                            icon: model.obscurePassword
                                ? Icon(
                                    FontAwesomeIcons.eye,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    FontAwesomeIcons.eyeSlash,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    model.passwordValidationMessage == null
                        ? Container()
                        : FormErrorContainer(
                            errorMsg: model.passwordValidationMessage,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 10),
                          child: RememberMeCheckbox(),
                        ),
//                      _buildPasswordForgetButton(context, model)
                      ],
                    ),
                    //@TODO : Check the size of device. Overflow on small devices
                    UIHelper.verticalSpace(30),
                    model.isBusy
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: Container(
                              width: 250,
                              child: Center(
                                child: Text(
                                  'Sign in'.i18n.toUpperCase(),
                                  style: kLoginButtonTextStyle,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                model.login();
                              }
                            })
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 10,
              //   width: MediaQuery.of(context).size.width,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     mainAxisSize: MainAxisSize.max,
              //     children: <Widget>[
              //       Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: _buildVersionText(model)),
              //     ],
              //   ),
              // ),
            ],
          ),
        )),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
