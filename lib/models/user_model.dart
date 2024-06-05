library; /// 1 class
/// 2 constructor
/// 3 fromJson
/// 4 toJson




class ChatUser {
  String? id;
  String? name;
  String? email;
  String? createdAt;
  String? lastActivated;
  String? pushToken;
  String? about;
  String? image;
  bool? online;
  List? myUsers;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.lastActivated,
    required this.pushToken,
    required this.about,
    required this.image,
    required this.online,
    required this.myUsers,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'] ??'',
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
      lastActivated: json['last_activated'],
      pushToken: json['push_token'],
      about: json['about'],
      image: json['image'],
      online: json['online'],
      myUsers: json['my_users']
    );
  }

 Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'name' : name,
      'email' : email,
      'created_at' : createdAt,
      'last_activated' : lastActivated,
      'push_token' : pushToken,
      'about' : about,
      'image' : image,
      'online' : online,
      'my_users' : myUsers,
    };
 }
}
