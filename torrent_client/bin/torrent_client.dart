import 'dart:io';

import 'package:torrent_client/torrent_client.dart' as Torrent;

void main(List<String> arguments) {
  var torrent = File(
    "5a982c32f9e5bb7939900c7ec896c17f3c2e1bca.torrent",
  ).readAsBytesSync();
  var d = Torrent.open(torrent);
  print(d.info.hash());
}
