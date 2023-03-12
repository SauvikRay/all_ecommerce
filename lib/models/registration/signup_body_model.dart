class SignUpBody{
  String first_name;
  String? last_name;
  String email;
  String password;

  SignUpBody({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password
  });

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();

    data["first_name"] = this.first_name;
    data["last_name"] = this.last_name;
    data["email"] = this.email;
    data["password"] = this.password;

    return data;
  }

}