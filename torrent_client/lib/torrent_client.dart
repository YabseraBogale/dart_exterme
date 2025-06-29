import 'dart:typed_data';

import 'package:b_encode_decode/b_encode_decode.dart' as bencode;

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
class BencodeInfo {}

/* BencodeTorrent  {
    announce-list List<dynamic>[
      List<dynamic>[
        Uint8List
      ]
    ]
    BencodeInfo info
  }
*/

class BencodeTorrent {}

void open(Uint8List byteStream) {
  var ben = bencode.decode(byteStream)["announce-list"];
  for (var i in ben) {
    for (var k in i) {
      print(k.runtimeType);
    }
  }
}
