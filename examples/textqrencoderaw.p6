#!/usr/bin/env perl6

# Set your terminal colors to white background with black characters

use lib 'lib';
use Image::QRCode;
use Image::QRCode :constants;

my QRinput $qrinput = QRinput_new;
QRinput_append($qrinput, QR_MODE_NUM, 3, '123');
my QRinput_Struct $qrstruct = QRinput_Struct_new;
QRinput_Struct_appendInput($qrstruct, $qrinput);
my QRcode_List $qrlist = QRcode_encodeInputStructured($qrstruct);
my $entry = $qrlist;
while $entry {
  my QRcode $qrcode = $entry.code;
  $entry = $entry.next;
  my uint8 @data := $qrcode.data;
  (@data[$_*21 .. $_*21+20] «+&» 1).join.trans('1' => "\c[FULL BLOCK]", '0' => ' ').subst(/(.)/, {"$0$0"}, :g).say for ^21;
}
