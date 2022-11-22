#!/usr/bin/env raku

use lib 'lib';
use Image::QRCode;

my $code = Image::QRCode.new.encode('https://raku.org/');
my $dim = $code.qrcode.width;
my @array2D[$dim;$dim] = $code.get-data(2);
say @array2D.shape;
say @array2D;
my @array1D = $code.get-data(1);
say @array1D;
