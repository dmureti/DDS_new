import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String userName;
  final String email;
  final String phone;

  UserAvatar({@required this.userName, @required this.email, this.phone});

  getUserInitials() {
    //Trim the whitespace from the name
    String trimmedName = userName.trim();
    List<String> splitName = trimmedName.split(' ');
    String initials =
        splitName[0].substring(0, 1) + splitName[1].substring(0, 1);
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _buildBottomModalSheet(context: context, email: email, name: userName);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            getUserInitials(),
            style:
                TextStyle(fontWeight: FontWeight.w700, color: Colors.blueGrey),
          )),
        ),
      ),
    );
  }

  _buildBottomModalSheet({BuildContext context, String email, String name}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              margin:
                  EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
//                  Text(
//                    'Contact Sheet'.toUpperCase(),
//                    style: TextStyle(
//                        fontSize: 22.0,
//                        fontWeight: FontWeight.w500,
//                        color: Colors.blueGrey),
//                  ),
//                  Divider(),
//                  SizedBox(
//                    height: 20,
//                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        minRadius: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(email),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(''),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text(''),
                    onTap: () {},
                  ),
                ],
              ),
            ));
  }
}
