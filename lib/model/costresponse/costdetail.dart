import 'package:equatable/equatable.dart';

class CostDetail extends Equatable {
  final int? value;
  final String? etd;
  final String? note;

  const CostDetail({this.value, this.etd, this.note});

  factory CostDetail.fromJson(Map<String, dynamic> json) => CostDetail(
        value: json['value'] as int?,
        etd: json['etd'] as String?,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'etd': etd,
        'note': note,
      };

  @override
  List<Object?> get props => [value, etd, note];
}
