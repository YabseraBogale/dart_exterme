import 'dart:ffi';
import 'dart:io';
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

  String buildTrackerURL(Uint8List peerId, Uint16 port) {
    List<String> uploaded = ["0"];
    List<String> downloaded = ["0"];
    List<String> compact = ["1"];
    List<String> left = [length.toString()];
    final Uri base = Uri.parse(announce);
    final Map<String, dynamic> params = {
      "info_hash": String.fromCharCodes(infoHash),
      "peer_id": String.fromCharCodes(peerId),
      "port": port.toString(),
      "uploaded": uploaded,
      "downloaded": downloaded,
      "compact": compact,
      "left": left,
    };
    final Uri trackerUri = base.replace(queryParameters: params);
    return trackerUri.toString();
  }
}

/*
 Peer{
	  IP   net.IP
	  Port uint16
  }
*/

class Peer {
  InternetAddress ip;
  Uint16 port = Uint16();
}

/*
  BencodeTrackerResp {
	  Interval int    
	  Peers    string 
  }

*/

class BencodeTrackerResp {
  int interval = 0;
  String peers = "";
}

List<Peer>? unmarshal(Uint8List peerBin) {
  var peerSize = 6;
  if (peerBin.length % peerSize == 0) {
    return null;
  }
  List<Peer> peers = [];
  var numberPeer = peerBin.length ~/ peerSize;
  for (var i = 0; i < numberPeer; i++) {
    var offSet = i * peerSize;
    var ipBytes = peerBin.sublist(offSet, offSet + 4);
    var ip = InternetAddress.fromRawAddress(ipBytes);
    var portBytesView = ByteData.view(
      peerBin.buffer,
      peerBin.offsetInBytes + offSet + 4,
      2,
    );
    int port = portBytesView.getInt16(0, Endian.big);
    var peer = Peer();
    peer.ip = ip;
  }
  return peers;
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
