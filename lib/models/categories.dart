class RoomCategory {
  static String sportID = "sports";
  static String moviesID = "movies";
  static String musicID = "music";

   String id;
  late String name;
  late String imagepath;

  RoomCategory(this.id, this.name, this.imagepath);

  RoomCategory.fromID(this.id) {
    name = id;
    imagepath = "assets/images/$id.png";
  }

  static List<RoomCategory>getCategories (){
    return [RoomCategory.fromID(RoomCategory.sportID) ,
      RoomCategory.fromID(RoomCategory.moviesID) ,
      RoomCategory.fromID(RoomCategory.musicID) ,
    ];
  }
}
