// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  final String _tag = 'PostAdapter: ';
  late final Directory document;
  PostAdapter() {
    init();
  }
  @override
  final int typeId = 1;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    File temp = File("${document.path}/${fields[3].hashCode}");
    if (!temp.existsSync()) {
      debugPrint(_tag + "이미지 생성");
      temp.writeAsBytesSync(fields[2]);
    }
    return Post(
      title: fields[0] == null ? '제목이 없습니다.' : fields[0] as String,
      content: fields[1] == null ? '내용이 없습니다.' : fields[1] as String,
      image: temp,
      writeDate: fields[3] as DateTime,
      duration: fields[4] == null ? 0 : fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    File temp = File("${document.path}/${obj.writeDate.hashCode}");
    if (!temp.existsSync()) {
      debugPrint(_tag + "이미지 복사해서 저장");
      temp.writeAsBytesSync(obj.image!.readAsBytesSync());
    }
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.image!.readAsBytesSync())
      ..writeByte(3)
      ..write(obj.writeDate)
      ..writeByte(4)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  void init() async {
    document = await getApplicationDocumentsDirectory();
  }
}
