
import 'package:json_annotation/json_annotation.dart';

class EnumConverter<T extends Enum>
    implements JsonConverter<T, String> {
  const EnumConverter(this.values);

  final List<T> values;

  @override
  T fromJson(String json) {
    return values.firstWhere(
          (value) => value.name == json,
      orElse: () => throw FormatException(
        'Unknown ${T.toString()} value: $json',
      ),
    );
  }

  @override
  String toJson(T object) => object.name;
}
