import 'package:distributor/ui/shared/text_styles.dart';
import 'package:distributor/ui/shared/widgets.dart';
import 'package:distributor/ui/views/login/login_viewmodel.dart';
import 'package:distributor/ui/widgets/smart_widgets/remember_me/remember_me_checkbox.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
// import 'login.i18n.dart';

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
                )
              : Container(),
        ),
        // resizeToAvoidBottomPadding: true,
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        colorFilter: ColorFilter.srgbToLinearGamma(),
                        image: AssetImage(
                            'assets/images/aromatic-board-bread-breakfast.jpg'),
                        fit: BoxFit.fill)),
              ),
              Form(
                key: _formKey,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UIHelper.verticalSpace(20),
                            LoginTextField(
                              text: 'SIGN IN',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormFieldPadding(
                              child: TextFormField(
                                controller: _userIdController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                                onChanged: (String val) {
                                  model.setUserId(val);
                                },
                                validator: (String value) {
                                  if (value != null) {
                                    return 'Please enter a valid email address or phone number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email Address / Phone ',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w600),
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
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
                                onChanged: (String val) =>
                                    model.updatePassword(val),
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                obscureText: model.obscurePassword,
                                decoration: InputDecoration(
                                  hintText: '*****',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w600),
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
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline),
                                      )),
                                )
                              ],
                            ),
                            UIHelper.verticalSpace(30),
                            model.isBusy
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : RaisedButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Container(
                                      width: 250,
                                      child: Center(
                                        child: Text(
                                          'Sign in'.toUpperCase(),
                                          style: kLoginButtonTextStyle,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      // if (_formKey.currentState.validate()) {
                                      model.login();
                                      // }
                                    }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(widget.userId, widget.password),
    );
  }
}
