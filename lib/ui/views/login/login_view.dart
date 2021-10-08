import 'package:distributor/src/ui/common/network_sensitive_widget.dart';
import 'package:distributor/src/ui/text_styles.dart';
import 'package:distributor/ui/config/brand.dart';
import 'package:distributor/ui/shared/text_styles.dart';
import 'package:distributor/ui/shared/widgets.dart';
import 'package:distributor/ui/views/login/login_viewmodel.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/smart_widgets/remember_me/remember_me_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LoginView extends StatefulWidget {
  final String userId;
  final String password;

  const LoginView({Key key, this.userId, this.password}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userIdController;
  TextEditingController _passwordController;
  @override
  void initState() {
    _userIdController = TextEditingController(text: widget.userId);
    _passwordController = TextEditingController(text: widget.password);
    super.initState();
  }

  @override
  void dispose() {
    _userIdController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            title: model.environments.length > 1
                ? _buildEnvironmentSelectionDropdown(model: model)
                : Container()),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_bg.jpg'),
                  fit: BoxFit.cover),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kDarkNeutral,
                    kDarkNeutral20,
                  ])),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NetworkSensitiveWidget(),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoginContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   child: Image.asset('assets/images/mini_logo.png'),
                          //   // width: 150,
                          //   height: 100,
                          // ),
                          LoginTextField(
                            text: 'DDS Sign In',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormFieldPadding(
                            child: TextFormField(
                              controller: _userIdController,
                              style: TextStyle(
                                  fontFamily: 'ProximaNova500',
                                  fontSize: 16,
                                  color: kDarkNeutral20),
                              onChanged: (String val) {
                                model.setUserId(val);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).nextFocus();
                              },
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              validator: (String value) {
                                if (value != null) {
                                  return 'Please enter a valid email address or phone number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Email Address / Phone ',
                                hintStyle: TextStyle(
                                    fontFamily: 'ProximaNovaRegular',
                                    fontSize: 12),
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                                  fontFamily: 'ProximaNova500',
                                  fontSize: 16,
                                  color: kDarkNeutral20),
                              onChanged: (String val) =>
                                  model.updatePassword(val),
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              obscureText: model.obscurePassword,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'password',
                                hintStyle:
                                    TextStyle(fontFamily: 'ProximaNovaRegular'),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: model.toggleObscurePassword,
                                  icon: model.obscurePassword
                                      ? Icon(
                                          FontAwesomeIcons.eye,
                                          size: 15,
                                          color: Colors.grey,
                                        )
                                      : Icon(
                                          FontAwesomeIcons.eyeSlash,
                                          size: 15,
                                          color: Colors.grey,
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
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 10),
                                child: RememberMeCheckbox(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 10),
                                child: FlatButton(
                                    onPressed: model.navigateToForgotPassword,
                                    child: Text(
                                      'Reset Password',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline),
                                    )),
                              )
                            ],
                          ),
                          UIHelper.verticalSpace(10),
                          model.isBusy
                              ? BusyWidget()
                              : RaisedButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Container(
                                    width: 250,
                                    child: Center(
                                      child: Text(
                                        'Sign in'.toUpperCase(),
                                        style: kActiveButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                  onPressed: model.userId == null ||
                                          model.password == null ||
                                          model.userId.isEmpty ||
                                          model.password.isEmpty
                                      ? null
                                      : () {
                                          // if (_formKey.currentState.validate()) {
                                          model.login();
                                          // }
                                        },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version : ${model.version}',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(widget.userId, widget.password),
    );
  }

  Widget _buildLoginContainer({Widget child}) {
    return SizedBox(
      width: 400,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: child,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: kDarkNeutral20,
              offset: Offset(1, 1),
              blurRadius: 6,
              spreadRadius: 0.8)
        ], borderRadius: BorderRadius.circular(4), color: Colors.white),
      ),
    );
  }

  Widget _buildEnvironmentSelectionDropdown({@required LoginViewModel model}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: DropdownButton(
            dropdownColor: Colors.white,
            isExpanded: true,
            onChanged: (AppEnv val) {
              model.updateEnv(val);
            },
            value: model.appEnv,
            items: model.environments
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.name,
                        style: TextStyle(color: Colors.black),
                      ),
                      value: e,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
