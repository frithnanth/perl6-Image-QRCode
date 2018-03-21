#!/usr/bin/env perl6

use lib 'lib';
use Image::QRCode;

my $code = Image::QRCode.new.encode('https://perl6.org/');
my $dim = $code.qrcode.width;
my @array[$dim;$dim] = $code.get-data(2);
say @array.shape;
say @array;
