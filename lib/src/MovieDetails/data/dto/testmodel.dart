

class User {
  String name ='';
  User({required this.name });

  User copyWith({String? name}){
    return User(name: name ?? this.name);
}

   User fromJson(Map<String, dynamic> json) {
    return  User(name: json['name'] ?? this.name);
  }


}


