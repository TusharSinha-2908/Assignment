import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User extends HiveObject{

  @HiveField(0)
  String name;

  @HiveField(1)
  int id;

  @HiveField(2)
  String accType;

  @HiveField(3)
  bool isSignIn;

  @HiveField(4)
  int age;

  @HiveField(5)
  String gender;

  User(this.name,this.id, this.accType, this.isSignIn, this.age, this.gender);

  factory User.fromJson(Map<String,dynamic> json)
  {
    // return User(
    //     name: json['name'],
    //     id: int.parse(json['id']),
    //     accType: json['atype'],
    //     isSignIn: false,
    //     age: 0,
    //     gender: 'Male',
    // );

    return User(
        json['name'],
        int.parse(json['id']),
        json['atype'],
        false,
        -1,
        'Null');
  }
}


class UserAdaptor extends TypeAdapter<User>{

  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    // TODO: implement read
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as bool,
      (fields[4] == null)? -1 : fields[4] as int,
      (fields[5] == null)? 'Null' : fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    // TODO: implement write
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.accType)
      ..writeByte(3)
      ..write(obj.isSignIn)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.gender);
  }
}