#!/usr/bin/env perl6

use Test;
use lib 'lib';
use Image::QRCode;
use Image::QRCode :constants;

my QRcode $qrcodestr = QRcode_encodeString('123', 0, QR_ECLEVEL_L, QR_MODE_8, 0);
my uint8 @data := $qrcodestr.data;
is @data[^21] «+&» 1,
  (1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1),
  'qrcode from string';
my QRcode $qrcode8bit = QRcode_encodeString8bit('123', 0, QR_ECLEVEL_L);
my uint8 @data8bit := $qrcodestr.data;
is @data8bit[^21] «+&» 1,
  (1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1),
  'qrcode from 8-bit data';
my QRcode $qrcodemqr = QRcode_encodeStringMQR('123', 1, QR_ECLEVEL_L, QR_MODE_8, 0);
my uint8 @datamqr := $qrcodemqr.data;
is @datamqr[^21] «+&» 1,
  (1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0),
  'MQR from string';
my QRcode $qrcodemqr8bit = QRcode_encodeString8bitMQR('123', 3, QR_ECLEVEL_L);
my uint8 @datamqr8bit := $qrcodemqr8bit.data;
is @datamqr8bit[^21] «+&» 1,
  (1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0),
  'MQR from 8-bit data';
my QRcode $qrcodedata = QRcode_encodeData(3, '123', 3, QR_ECLEVEL_L);
my uint8 @datadata := $qrcodedata.data;
is @datadata[^21] «+&» 1,
  (1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0),
  'qrcode from data';
my QRcode $mqrdata = QRcode_encodeDataMQR(3, '123', 3, QR_ECLEVEL_L);
my uint8 @datamqr1 := $mqrdata.data;
is @datamqr1[^21] «+&» 1,
  (1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0),
  'qrcode from data';
my QRinput $qrinput = QRinput_new;
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
  is QRcode_List_size($qrlist), 1, 'list size';
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
