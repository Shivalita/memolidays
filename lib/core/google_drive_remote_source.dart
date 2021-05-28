import 'dart:io';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memolidays/features/login/domain/models/google_auth_client.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class GoogleDriveRemoteSource {

  final LocalSource localSource = LocalSource();
  final GoogleSignIn googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
  GoogleAuthClient authenticateClient;
  drive.DriveApi driveApi;

  GoogleDriveRemoteSource._();
  static GoogleDriveRemoteSource _cache;
  factory GoogleDriveRemoteSource() => _cache ??= GoogleDriveRemoteSource._();

  void authenticateDriveApi() async {
    final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
    final signIn.GoogleSignInAccount account = await googleSignIn.signIn();
    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final authenticatedDriveApi = drive.DriveApi(authenticateClient);
    driveApi = authenticatedDriveApi;
  }

  uploadFileToGoogleDrive(AssetEntity asset, String name) async {
    try {
      File file = await asset.file;
      var media = new drive.Media(file.openRead(), file.lengthSync());
      var driveFile = new drive.File()..name = name;
      // return driveApi.files.create(driveFile, uploadMedia: media).then((drive.File uploadedFile) {
      //   print('Uploaded $file. Id: ${uploadedFile.id}');
      //   print('Uploaded $file. Extension: ${uploadedFile.fileExtension}');
      // });
      var uploadedFile = await driveApi.files.create(driveFile, uploadMedia: media);
  
      return uploadedFile;
    }

    catch (error) {
      print('GOOGLE DRIVE API AUTHENTICATION ERROR : $error');
      throw Exception();
    }
  }
}