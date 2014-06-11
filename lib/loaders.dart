part of hacksim;

class ImageLoader {
  Map<String, ImageElement> images;
  Function complete;

  int total;

  ImageLoader(Function on_completion, Map<String,String> load) {
    images = new Map<String, ImageElement>();
    var futures = new List<Future<Event>>();

    for (String img in load.keys) {
      // because of cors this doesn't work for arbitrary urls
      // workaround: upload to imgur and then grab the image data from there
      // add new_image.crossOrigin = "Anonymous" i think
      ImageElement new_image = new ImageElement(src: load[img]);
      images[img] = new_image;
      futures.add(new_image.onLoad.first);
    }
    Future.wait(futures).then((e) => on_completion());
  }
}

