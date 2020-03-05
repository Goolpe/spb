import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shelters/shelf.dart';

class CreateModel with ChangeNotifier{
  DatabaseReference _dbRef;

  String _name = '';
  String get name => _name;

  String _type = '';
  String get type => _type;

  String _age = '';
  String get age => _age;

  DateTime _dateOfBirth;
  DateTime get dateOfBirth => _dateOfBirth;

  String _breed;
  String get breed => _breed;

  List<PictureModel> _pictures = [];
  List<PictureModel> get pictures => _pictures;

  List<Asset> _oldPictures = [];

  void init(){
    _dbRef = FirebaseDatabase.instance.reference();
  }

  void changeName(String name){
    _name = name;
    notifyListeners();
  }

  void changeType(String type){
    _type = type;
    notifyListeners();
  }

  void changeDateOfBirth(DateTime dateOfBirth){
    _dateOfBirth = dateOfBirth;
    notifyListeners();
  }

  void changeBreed(String breed){
    _breed = breed;
    notifyListeners();
  }

  void changeAge(String age){
    _age = age;
    notifyListeners();
  }

  void create(){
    _dbRef.push().set({
      'name': _name,
      'url': "https://cdn2.thecatapi.com/images/6mt.jpg",
      'type': _type,
      'breed': _breed,
      'age': _age
    });
  }

  void changePictures() async{
    try{
      
      List<Asset> _newPictures = await MultiImagePicker.pickImages(
        maxImages: 4,
        selectedAssets: _oldPictures
      );
      _pictures = [];

      for(Asset pic in _newPictures){
        PictureModel picture = PictureModel();

        ByteData byteData = await pic.getByteData();
        picture.id = pic.identifier;
        picture.uint8 = byteData.buffer.asUint8List();
        picture.asset = pic;
        _pictures.add(picture);
        _oldPictures.add(pic);
      }

      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }

  void removePicture(PictureModel picture) async{
    try{
      _pictures.remove(picture);
      _oldPictures.remove(picture.asset);

      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }
}