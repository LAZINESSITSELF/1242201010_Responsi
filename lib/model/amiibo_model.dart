class amiibo{
  final String amiiboSeries;
  final String char;
  final String gameSeries;
  final String head;
  final String image;
  final String name;
  final String tail;
  final String type;

  amiibo(
    {
      required this.amiiboSeries,
      required this.char,
      required this.gameSeries,
      required this.head,
      required this.image,
      required this.name,
      required this.tail,
      required this.type
    }
  );

  factory amiibo.fromJson(Map<String,dynamic> json){
    return amiibo(
      amiiboSeries: json['amiiboSeries'], 
      char: json['character'], 
      gameSeries: json['gameSeries'], 
      head: json['head'], 
      image: json['image'], 
      name: json['name'], 
      tail: json['tail'], 
      type: json['type']
    );
  }
}