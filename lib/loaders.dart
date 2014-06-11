// I tried making an assetloader with generics but apparently you can't instantiate an object of the generic type?
// maybe i was just doing it wrong

import 'dart:html';
import 'dart:async';

class ImageLoader {
  Map<String, ImageElement> images;

  // load is a map of 'asset name':'path to asset'
  ImageLoader(Function on_completion, Map<String,String> load) {
    images = new Map<String, ImageElement>();
    var futures = new List<Future<Event>>();

    for (String name in load.keys) {
      // because of cors this doesn't work for arbitrary urls
      // workaround: upload to imgur and then grab the image data from there
      // add new_image.crossOrigin = "Anonymous" i think
      ImageElement new_image = new ImageElement(src: load[name]);
      images[name] = new_image;
      futures.add(new_image.onLoad.first);
    }
    if (futures.isNotEmpty) {
      Future.wait(futures).then((e) => on_completion());
    }
    else {
      on_completion();
    }
  }
}

// so i couldn't figure out how to do the thing with the futures that i did with the images.
// onLoad, onCanPlay, and onLoadedData all seemed to not work.
class VideoLoader {
  Map<String, VideoElement> videos;

  // load is a map of 'asset name':'path to asset'
  VideoLoader(Function on_completion, Map<String,String> load) {
    videos = new Map<String, VideoElement>();
    var futures = new List<Future<Event>>();

    for (String name in load.keys) {
      VideoElement new_video = new VideoElement();
      new_video.src = load[name];
      new_video.autoplay = false;
      // set size and when to play when actually used in canvas

      videos[name] = new_video;
    }
    on_completion();
  }
}
