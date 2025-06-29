import 'dart:typed_data';

import 'package:b_encode_decode/b_encode_decode.dart' as bencode;

class BencodeInfo {
  String pieces = "";
  String name = "";
  int piecesLength = 0;
  int length = 0;
}

class BencodeTorrent {
  String announce = "";
  BencodeInfo info = BencodeInfo();
}

void open(Uint8List byteStream) {
  var ben = bencode.decode(byteStream);
  print(ben);
}
