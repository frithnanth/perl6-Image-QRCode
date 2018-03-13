#!/usr/bin/env perl6

use Test;
use lib 'lib';
use Image::QRCode;
use Image::QRCode :constants;

my QRinput $qrinput = QRinput_new;
is $qrinput.WHAT, QRinput, 'QRinput_new';
is QRinput_check(QR_MODE_NUM, 3, '123'), 0, 'check valid data before appending';
my int32 $res = QRinput_check(QR_MODE_NUM, 3, 'a123');
is $res, -1, 'check invalid data before appending';
is QRinput_append($qrinput, QR_MODE_NUM, 3, '123'), 0, 'append data';
is QRinput_appendECIheader($qrinput, 10000), 0, 'append ECI header';
my QRinput_Struct $qrstruct = QRinput_Struct_new;
is $qrstruct.WHAT, QRinput_Struct, 'QRinput_Struct_new';
subtest {
  $res = QRinput_Struct_appendInput($qrstruct, $qrinput);
  ok $res == 1, 'append one object';
  my QRcode_List $qrlist = QRcode_encodeInputStructured($qrstruct);
  is $qrlist.WHAT, QRcode_List, 'call QRcode_encodeInputStructured';
  my $entry = $qrlist;
  while $entry {
    my QRcode $qrcode = $entry.code;
    $entry = $entry.next;
    is $qrcode.version, 1, 'qrcode version';
    is $qrcode.width, 21, 'qrcode width';
    my uint8 @data := $qrcode.data;
    is @data[^21] «+&» 1,
      (1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1),
      'qrcode data';
  }
}, 'append input to a QRinput_struct';
done-testing;
