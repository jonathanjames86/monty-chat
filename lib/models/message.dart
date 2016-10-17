class Message{
  final String name;
  final String text;
  final String date;
  String photoURL;
  String imageURL;

  Message(this.name, [this.text, this.date, String photoURL, this.imageURL]){
      this.photoURL = photoURL ?? "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg";
  }

  Message.fromMap(Map map) :
       this(map['name'], map['text'], map['date'], map['photoURL'], map['imageURL']);

 Map toMap() => {
   "name": name,
   "text": text,
   "date": date,
   "photoURL": photoURL,
   "imageURL": imageURL
 };
}
