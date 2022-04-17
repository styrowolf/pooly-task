import 'package:flutter/material.dart';
import 'dart:io';

class Profile {
  final String name;
  final String surname;
  final int age;
  final String university;
  final String major;
  final String email;
  final ImageWrapper profilePhoto;

  const Profile(
    this.name, 
    this.surname,
    this.age,
    this.university,
    this.major,
    this.email,
    this.profilePhoto,
  );

  static const List<Profile> profiles = [

  ];
}

class ImageWrapper {
  final String pathToImage;
  final ImageType type;

  const ImageWrapper(this.pathToImage, this.type);

  ImageProvider toImageProvider() {
    if (type == ImageType.asset) {
      return AssetImage(pathToImage);
    } else if (type == ImageType.file) {
      return FileImage(File(pathToImage));
    } else if (type == ImageType.network) {
      return NetworkImage(pathToImage);
    } else {
      throw Exception("unreachable");
    }
  }
}

enum ImageType {
  network,
  asset,
  file,
}