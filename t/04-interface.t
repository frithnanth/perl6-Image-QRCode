#!/usr/bin/env perl6

use Test;
use lib 'lib';
use Image::QRCode;
use Image::QRCode :constants;

my $qrcode = Image::QRCode.new;
is $qrcode.WHAT, Image::QRCode, 'new object';
is $qrcode.level, QR_ECLEVEL_L, 'qrcode level';
is $qrcode.termplot.WHAT, Failure, 'failure when no data to plot';
is $qrcode.qrcode.defined, False, 'qrcode present and undefined';
$qrcode.encode('https://perl6.org/', :level(QR_ECLEVEL_M));
is $qrcode.qrcode.defined, True, 'encode a string';

done-testing;
