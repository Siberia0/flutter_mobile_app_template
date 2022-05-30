import 'package:flutter_mobile_app_template/entity/user/additional_info_entity.dart';

class UserEntity {
  final String userId;
  final String userName;
  final List<AdditionalInfoEntity> additionalInfo;

  UserEntity(
    this.userId,
    this.userName,
    this.additionalInfo,
  );

  UserEntity.fromJson(Map<String, dynamic> json)
      : userId = json.containsKey('userId') ? json['userId'] : '',
        userName = json.containsKey('userName') ? json['userName'] : '',
        additionalInfo = json.containsKey('additionalInfo')
            ? (json['additionalInfo'] as List)
                .map((e) => AdditionalInfoEntity.fromJson(e))
                .toList()
            : [];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'additionalInfo': additionalInfo,
      };
}
