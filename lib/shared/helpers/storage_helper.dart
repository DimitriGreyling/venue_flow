// lib/shared/helpers/storage_helper.dart
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue_flow_app/constants/storage_form_keys.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';

abstract class IStorageHelper {
  Future<void> saveForm(DynamicFormModel form);
   Future<List<DynamicFormModel>?> loadForm();
  Future<void> clearForms();
}

class StorageHelper implements IStorageHelper {
  
  @override
  Future<void> saveForm(DynamicFormModel form) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = form.toJsonString();
      await prefs.setString(StorageFormKeys.storageFormKey, jsonString);
      log('Form saved successfully');
    } catch (e) {
      log('Error saving form: $e');
      throw StorageException('Failed to save form');
    }
  }
  
  @override
  Future<List<DynamicFormModel>?> loadForm() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(StorageFormKeys.storageFormKey);
      
      if (jsonString != null && jsonString.isNotEmpty) {
        final json = jsonDecode(jsonString);
        return [DynamicFormModel.fromJson(json)];
      }
      return null;
    } catch (e) {
      log('Error loading form: $e');
      return null;
    }
  }
  
  @override
  Future<void> clearForms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageFormKeys.storageFormKey);
    } catch (e) {
      log('Error clearing forms: $e');
    }
  }
}

class StorageException implements Exception {
  final String message;
  StorageException(this.message);
}