import 'package:flutter/material.dart';
import 'package:macro_counter/data/io_dao.dart';
import 'package:macro_counter/models/user_settings.dart';
import 'package:macro_counter/providers/io_object_provider.dart';

class UserSettingsProvider
    with ChangeNotifier
    implements IoObjectProvider<UserSettings> {
  final IoDao<UserSettings> _userSettingsDao;
  UserSettings? settings;

  UserSettingsProvider(this._userSettingsDao);

  @override
  Future<UserSettings?> get object async {
    settings ??= await _userSettingsDao.read();
    return settings;
  }

  @override
  Future<void> addObject(UserSettings object) async {
    await _userSettingsDao.insert(object);
    settings = object;
    notifyListeners();
  }
}
