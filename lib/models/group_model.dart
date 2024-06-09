// library; /// 1 class
// /// 2 constructor
// /// 3 fromJson
// /// 4 toJson

class ChatGroup {
  String id;
  String name;
  String image;
  List members;
  List admin;
  String lastMessage;
  String lastMessageTime;
  String createdAt;

  ChatGroup({
    required this.id,
    required this.name,
    required this.image,
    required this.admin,
    required this.createdAt,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatGroup.fromJson(Map<String, dynamic> json) {
    return ChatGroup(
      id: json['id'] ?? '',
      createdAt: json['created_at'],
      members: json['members'] ?? [],
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: json['last_message_time'] ?? '',
      name: json['name'] ?? '',
      admin: json['admins_id'] ?? [],
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'members': members,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'name' : name,
      'admins_id' : admin,
      'image' : image,

    };
  }
}
