import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_customer_to_org.freezed.dart';
part 'link_customer_to_org.g.dart';

@freezed
abstract class LinkCustomerToOrg with _$LinkCustomerToOrg {
  const factory LinkCustomerToOrg({
    required String roleId,
    required String userId,
  }) = _LinkCustomerToOrg;

  factory LinkCustomerToOrg.fromJson(Map<String, dynamic> json) =>
      _$LinkCustomerToOrgFromJson(json);
}
