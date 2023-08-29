import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}

String monthInLetter(int month) {
  String lettre = "";
  switch (month) {
    case 1:
      lettre = "Janv.";
      break;
    case 2:
      lettre = "Févr.";
      break;
    case 3:
      lettre = "Mars";
      break;
    case 4:
      lettre = "Avril";
      break;
    case 5:
      lettre = "Mai";
      break;
    case 6:
      lettre = "Juin";
      break;
    case 7:
      lettre = "Juil.";
      break;
    case 8:
      lettre = "Aout";
      break;
    case 9:
      lettre = "Sept.";
      break;
    case 10:
      lettre = "Oct!;";
      break;
    case 11:
      lettre = "Nov.";
      break;
    default:
      lettre = "Déc.";
  }
  return lettre;
}

// Icon IconForPost(String communityName){
//   switch (communityName) {
//     case "":
      
//       break;
//     default:
//   }
// }