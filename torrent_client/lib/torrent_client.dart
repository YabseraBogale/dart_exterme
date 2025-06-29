import 'dart:typed_data';

import 'package:b_encode_decode/b_encode_decode.dart' as bencode;
import 'package:crypto/crypto.dart';
/*
  BencodeInfo {
    files List<dynamic>[
      Map<String, dynamic>{
        length int,
        md5sum Uint8List,
        path List<dynamic>
      }
    ],
    name Uint8List,
    piece length int,
    pieces Uint8List,
    private int,
    source Uint8List,
  }

*/

class BencodeInfo {
  List<dynamic> files = [];
  Uint8List? name;
  int pieceLength = 0;
  Uint8List? pieces;
  int private = 0;
  Uint8List? source;

  Digest hash() {
    Uint8List hash = bencode.encode(this);
    Digest digest = sha1.convert(hash);
    return digest;
  }

  @override
  String toString() {
    return "BencodeInfo(files: $files, name: $name,pieceLength: $pieceLength,pieces: $pieces, private: $private, source: $source)";
  }
}

/* BencodeTorrent  {
    announce-list List<dynamic>[
      List<dynamic>[
        Uint8List
      ]
    ]
    BencodeInfo info
  }
*/

class BencodeTorrent {
  List<dynamic> announceList = [];
  BencodeInfo info = BencodeInfo();
  @override
  String toString() {
    return "BencodeTorrent(announceList: $announceList, info: $info)";
  }
}

/*
  TorrentFile {
    Announce    string
    InfoHash    Uint8List
    PieceHashes List<dynamic>
    PieceLength int
    Length      int
    Name        string
  }

*/
class TorrentFile {
  String announce = "";
  Uint8List infoHash = Uint8List(20);
  List<dynamic> pieceHashes = [];
  int pieceLength = 0;
  int length = 0;
  String name = "";
}

BencodeTorrent open(Uint8List byteStream) {
  BencodeTorrent bto = BencodeTorrent();
  var ben = bencode.decode(byteStream);
  Map<String, dynamic> info = ben["info"];

  bto.announceList = ben["announce-list"];
  bto.info.files = info["files"];
  bto.info.name = info["name"];
  bto.info.pieceLength = info["piece length"];
  bto.info.pieces = info["pieces"];
  bto.info.private = info["private"];
  bto.info.source = info["source"];
  return bto;
}
