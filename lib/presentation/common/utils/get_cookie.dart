import 'dart:io';

import 'package:shift/domain/account/account.dart';
import 'package:shift/infrastructure/account/account_entity.dart';
import 'package:shift/infrastructure/auth/contractor/document/upload_document_dto.dart';
import 'package:shift/infrastructure/core/network/hive_box_names.dart';
import 'package:hive/hive.dart';

String? getUserToken() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.userToken);
}

/// CUREENT USER
Future<void> setCurrentRole(int selectedUser) async {
  return await Hive.box(BoxNames.settingsBox)
      .put(BoxKeys.currentUser, selectedUser);
}

int? getCurrentRole() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.currentUser);
}

void setCurrentUser(Account account) {
  // Hacky solution to allow testing
  if (!Platform.environment.containsKey('FLUTTER_TEST')) {
    final box = Hive.box<AccountEntity>(BoxNames.currentUser);
    box.put(BoxKeys.currentKey, AccountEntity.fromDomain(account));
  }
}

/// CUREENT INDUSTRY
Future<void> setCurrentIndustry(int selectedIndustry) async {
  return await Hive.box(BoxNames.settingsBox)
      .put(BoxKeys.currentIndustry, selectedIndustry);
}

int? getCurrentIndustry() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.currentUser);
}

/// Show Onboarding / Introduction screen or not

Future<void> setUserShowIntro(bool showIntro) async {
  return await Hive.box(BoxNames.settingsBox)
      .put(BoxKeys.isUserShowIntro, showIntro);
}

bool? getUserShowIntro() {
  return Hive.box(BoxNames.settingsBox).get(BoxKeys.isUserShowIntro);
}

String getGovernmentIssueId() {
  return Hive.box(BoxNames.cotractorDocumentBox)
          .get(BoxKeys.governmentIssueId) ??
      "";
}

String getCovidVaccinationDoc() {
  return Hive.box(BoxNames.cotractorDocumentBox)
          .get(BoxKeys.covidVaccinationDoc) ??
      "";
}

CredentialRegistrationDTO getCredentialRegistrationDoc() {
  return Hive.box(BoxNames.cotractorDocumentBox)
          .get(BoxKeys.credentialRegistrationDoc) ??
      "";
}

// String? getRememberToken() {
//   return Hive.box(BoxNames.settingsBox).get(BoxKeys.rememberToken);
// }

// bool? isUserShowIntro() {
//   return Hive.box(BoxNames.settingsBox).get(BoxKeys.isUserShowIntro);
// }

// Future<String?> getDeviceId() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     return androidInfo.id;
//   } else {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     return iosInfo.identifierForVendor ?? '';
//   }
// }
