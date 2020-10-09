//! Usecase base model
import 'package:flutter/material.dart';

abstract class Usecase {
  dynamic call(BuildContext context);
}