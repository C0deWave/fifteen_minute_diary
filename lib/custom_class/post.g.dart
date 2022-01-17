// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  final String _tag = 'PostAdapter: ';
  late final Directory document;
  PostAdapter({String? path}) {
    init(path: path);
  }
  @override
  final int typeId = 1;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    List<File> imagelist = [];
    for (var i = 0; i < fields[2]; i++) {
      File temp = File("${document.path}/${fields[3].hashCode}$i");
      if (!temp.existsSync()) {
        debugPrint(_tag + "이미지 생성");
        temp.writeAsBytesSync(fields[5 + i]);
      }
      imagelist.add(temp);
    }

    return Post(
      title: fields[0] == null ? '제목이 없습니다.' : fields[0] as String,
      content: fields[1] == null ? '내용이 없습니다.' : fields[1] as String,
      imagelist: imagelist,
      writeDate: fields[3] as DateTime,
      duration: fields[4] == null ? 0 : fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(5 + obj.imagelist!.length)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.imagelist!.length)
      ..writeByte(3)
      ..write(obj.writeDate)
      ..writeByte(4)
      ..write(obj.duration);
    for (var i = 5; i < 5 + obj.imagelist!.length; i++) {
      writer
        ..writeByte(i)
        ..write(obj.imagelist![i - 5].readAsBytesSync());
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  void init({String? path}) async {
    if (path != null) {
      document = Directory(path);
    } else {
      document = await getApplicationDocumentsDirectory();
    }
  }
}
