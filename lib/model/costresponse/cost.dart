import 'package:equatable/equatable.dart';
import 'package:ongkir_api/model/costresponse/costdetail.dart';

class Cost extends Equatable {
  final String? service;
  final String? description;
  final List<CostDetail>? cost; // Change this to List<CostDetail>?

  const Cost({this.service, this.description, this.cost});

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        service: json['service'] as String?,
        description: json['description'] as String?,
        cost: (json['cost'] as List<dynamic>?)
            ?.map((e) => CostDetail.fromJson(e as Map<String, dynamic>))
            .toList(), // Map to a list of CostDetail
      );

  Map<String, dynamic> toJson() => {
        'service': service,
        'description': description,
        'cost': cost?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [service, description, cost];
}
