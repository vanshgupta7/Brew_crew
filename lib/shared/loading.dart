import 'package:flutter/material.dart';

//ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[400],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50,
        ),
      ),
    );
  }
}
