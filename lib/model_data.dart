class DataModel {
  String name;
  String job;
  String platfrom;
  int age;
  String urlImg;
  String linkintro;
  String urlHTML5;

  DataModel({
    this.name,
    this.job,
    this.platfrom,
    this.age,
    this.urlImg,
    this.linkintro,
    this.urlHTML5
  });

  factory DataModel.fromJson(Map<String, dynamic> parsedJson) {
    return DataModel(
      name: parsedJson['name'],
      job: parsedJson['job'],
      platfrom: parsedJson['Platform'],
      age: parsedJson['Age'],
      urlImg: parsedJson['link'],
      linkintro: parsedJson['linkintro'],
      urlHTML5: parsedJson['game']['html5'],
    );
  }
}
