import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shift/infrastructure/account/account_entity.dart';
import 'package:shift/infrastructure/core/network/hive_box_names.dart';

Future<void> setupHive() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(AccountEntityAdapter());
  await Hive.openBox<AccountEntity>(BoxNames.currentUser);
  await Hive.openBox(BoxNames.settingsBox);
  await Hive.openBox(BoxNames.cotractorDocumentBox);
}
