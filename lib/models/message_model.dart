library; /// 1 class
/// 2 constructor
/// 3 fromJson
/// 4 toJson


/// for message model i will use ...
/// id , from_id , to_id , message , created_at , read , type

class MessageModel {
  String? id;
  String? toId;
  String? fromId;
  String? message;
  String? createdAt;
  String? read;
  String? type;

  MessageModel({
    required this.id,
    required this.toId,
    required this.fromId,
    required this.message,
    required this.createdAt,
    required this.read,
    required this.type,

  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ??'',
      toId: json['to_id'],
      fromId: json['from_id'],
      createdAt: json['created_at'],
      message: json['message'],
      read: json['read'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'to_id' : toId,
      'from_id' : fromId,
      'created_at' : createdAt,
      'message' : message,
      'read' : read,
      'type' : type,

    };
  }
}
