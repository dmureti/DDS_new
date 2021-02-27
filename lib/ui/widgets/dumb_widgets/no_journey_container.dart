import 'package:flutter/material.dart';

class NoJourneyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/no_journey.png',
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'You have not been assigned any deliveries today.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}
