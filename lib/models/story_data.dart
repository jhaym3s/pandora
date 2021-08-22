import 'package:flutter/cupertino.dart';
import 'package:meta/meta_meta.dart';

@immutable
class StoryData{
  const StoryData({
      required this.name,required this.url
  });

  final String name;
  final String url;
}