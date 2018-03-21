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
my @array1D = $qrcode.get-data(1);
is @array1D.elems, $qrcode.qrcode.width * $qrcode.qrcode.width, 'read 1D data';
my @array2D[$qrcode.qrcode.width;$qrcode.qrcode.width] = $qrcode.get-data(2);
is @array2D.elems, $qrcode.qrcode.width, 'read 2D data';
is $qrcode.get-data(3).WHAT, Failure, 'failure requesting 3D data';
is $qrcode.get-data.WHAT, Failure, 'failure requesting 0D data';

done-testing;
