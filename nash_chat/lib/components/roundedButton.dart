import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.title,
    required this.clr,
    required this.onTap,
  });
  final String title;
  final Color clr;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: clr,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onTap();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// **************************
// RoundedField(
//                 hint: 'Enter your password.',
//                 clr: Colors.lightBlueAccent,
//                 onChange: (value) {
//                   //Nthing
//                 }),
/// *************************
//  class RoundedField extends StatelessWidget {
//   const RoundedField({
//     Key? key,
//     required this.clr,
//     required this.hint,
//     required this.onChange,
//   }) : super(key: key);

//   final String hint;
//   final Color clr;
//   final Function onChange;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: (v) {
//         onChange(v);
//       },
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.black),
//         contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(32.0)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: clr, width: 1.0),
//           borderRadius: BorderRadius.all(Radius.circular(32.0)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: clr, width: 2.0),
//           borderRadius: BorderRadius.all(Radius.circular(32.0)),
//         ),
//       ),
//     );
//   }
// }
