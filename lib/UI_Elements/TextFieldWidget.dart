// import 'package:flutter/material.dart';

// class TextFieldWidget extends StatelessWidget {
//   final String? labelText;
//   final IconData? prefixIconData;
//   final IconData? suffixIconData;
//   final bool? obsecureText;
//   final Function onChanged;
//   final Function validator;
//   final Function onSaved;
//   final TextInputType keyboardType;
//   final ValueKey valueKey;

//   const TextFieldWidget(
//       {Key? key,
//       this.labelText,
//       this.prefixIconData,
//       this.suffixIconData,
//       this.obsecureText,
//       required this.onChanged,
//       required this.validator,
//       required this.onSaved,
//       required this.keyboardType,
//       required this.valueKey})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       key: valueKey,
//       keyboardType: keyboardType,
//       onChanged: onChanged,
//       validator: validator,
//       onSaved: onSaved,
//       obscureText: obsecureText,
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 16.0,
//       ),
//       decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: Container(
//             padding: EdgeInsets.all(2),
//             child: Icon(
//               prefixIconData,
//               size: 18,
//               color: Colors.white,
//             ),
//           ),
//           filled: true,
//           fillColor: Colors.white12,
//           enabledBorder: UnderlineInputBorder(
//             borderRadius: BorderRadius.circular(27),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(27),
//             borderSide: BorderSide(color: Colors.white),
//           ),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(27),
//               borderSide: BorderSide(color: Colors.red)),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(27),
//               borderSide: BorderSide(color: Colors.red)),
//           suffixIcon: Icon(
//             suffixIconData,
//             size: 18,
//             // color: Color(0xFF474646),
//             color: Colors.white,
//           ),
//           labelStyle: TextStyle(
//               color: Colors.white, fontFamily: 'Corbel', fontSize: 18),
//           focusColor: Colors.white12),
//     );
//   }
// }
