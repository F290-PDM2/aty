import 'package:flutter/material.dart';

@immutable
class AtySemanticColors extends ThemeExtension<AtySemanticColors> {
  const AtySemanticColors({
    required this.like,
    required this.trending,
    required this.highlight,
  });

  final Color like;
  final Color trending;
  final Color highlight;

  @override
  AtySemanticColors copyWith({Color? like, Color? trending, Color? highlight}) {
    return AtySemanticColors(
      like: like ?? this.like,
      trending: trending ?? this.trending,
      highlight: highlight ?? this.highlight,
    );
  }

  @override
  AtySemanticColors lerp(covariant AtySemanticColors? other, double t) {
    if (other == null) return this;
    return AtySemanticColors(
      like: Color.lerp(like, other.like, t)!,
      trending: Color.lerp(trending, other.trending, t)!,
      highlight: Color.lerp(highlight, other.highlight, t)!,
    );
  }
}
