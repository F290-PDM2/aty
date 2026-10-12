import 'package:aty/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.avatarUrl,
    required super.role,
  });

  factory UserModel.fromSupabaseUser(User user) {
    final metaData = user.userMetadata ?? {};
    return UserModel(
      id: user.id,
      username: metaData['username'] as String? ?? '',
      avatarUrl: metaData['avatar_url'] as String?,
      role: metaData['role'] as String? ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  @JsonKey(name: 'avatar_url')
  @override
  String? get avatarUrl;
}
