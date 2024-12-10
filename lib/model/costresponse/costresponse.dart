import 'package:equatable/equatable.dart';

import 'cost.dart';

class Costresponse extends Equatable {
  final String? code;
  final String? name;
  final List<Cost>? costs;

  const Costresponse({this.code, this.name, this.costs});

  factory Costresponse.fromJson(Map<String, dynamic> json) => Costresponse(
        code: json['code'] as String?,
        name: json['name'] as String?,
        costs: (json['costs'] as List<dynamic>?)
            ?.map((e) => Cost.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'costs': costs?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [code, name, costs];
}
