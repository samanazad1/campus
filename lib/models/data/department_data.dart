import 'package:campus/models/model/department_model.dart';

List<Department> _list = [
  Department(1, "1", "Software"),
  Department(2, "2", "Civil"),
  Department(3, "3", "Architecture"),
  Department(4, "4", "Electrical"),
  Department(5, "5", "Mechanical & Mechatronic"),
  Department(6, "6", "Surveying"),
  Department(7, "7", "Petro Chemical"),
  Department(8, "8", "Water Resourcces"),
];
List<Department> get availableDeps => _list;
