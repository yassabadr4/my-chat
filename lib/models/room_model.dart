// library; /// 1 class
// /// 2 constructor
// /// 3 fromJson
// /// 4 toJson

class ChatRoom {
  String? id;
  List? members;
  String? lastMessage;
  String? lastMessageTime;
  String? createdAt;

  ChatRoom({
    required this.id,
    required this.createdAt,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] ?? '',
      createdAt: json['created_at'],
     members: json['members'] ?? [],
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: json['last_message_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'members': members,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
    };
  }
}
