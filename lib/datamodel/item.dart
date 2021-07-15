class Item {
  int id;
  String name;
  String description;
  ImageDetails imageDetails;
  num price;
  Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageDetails,
      required this.price});
}

class ImageDetails {
  String name;
  String mimeType;
  String url;
  ImageDetails({required this.name, required this.url, required this.mimeType});
}
