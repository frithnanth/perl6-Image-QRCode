#!/usr/bin/env raku

# Set your terminal colors to white background with black characters

use lib 'lib';
use Image::QRCode;

Image::QRCode.new.encode('https://raku.org/').termplot;
