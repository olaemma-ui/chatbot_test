// ignore_for_file: non_constant_identifier_names

part of 'asset_manager.dart';

abstract class AssetManager {
  static final _assetManager = _AssetManager();

  static final logo = _assetManager.getSvgAsset('logo.svg');
  static final group = _assetManager.getSvgAsset('group.svg');
  static final hambugger = _assetManager.getSvgAsset('hambugger.svg');
  
}
