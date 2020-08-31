class Order {
  int id;
  String image;
  String title;
  String description;
  String telephone;
  DateTime pubDate;
  int cost;
  int viewsCount;

  Order({
    this.id,
    this.image,
    this.title,
    this.description,
    this.telephone,
    this.cost,
    this.pubDate,
    this.viewsCount});

  Map<String, dynamic> toJson() =>
      {
        "image": this.image,
        "title": this.title,
        "description": this.description,
        "telephone": this.telephone,
        "cost": this.cost.toString(),
        "pubDate": this.pubDate.toString(),
        "viewsCount": this.viewsCount.toString(),
      };

  factory Order.fromJson(Map<String, dynamic> fields) => Order(
        image: fields["image"],
        title: fields["title"],
        description: fields["description"],
        telephone: fields["telephone"],
        cost: fields["cost"],
        pubDate: DateTime.parse(fields["pubDate"]),
        viewsCount: fields["viewsCount"],
  );
}
