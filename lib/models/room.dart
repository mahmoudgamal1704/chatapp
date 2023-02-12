class Room {

  static const String CollectrionName ="Rooms";
  String id;
  String title;
  String description;
  String categID;


  Room({ this.id ="", required this.title, required this.description, required this.categID});

  Room.fromJson(Map<String,dynamic> json):this(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      categID: json["categID"]
  );
  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "title":title,
      "description":description,
      "categID":categID,
    };
  }
}