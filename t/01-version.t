#!/usr/bin/env perl6

use Test;
use lib 'lib';
use Image::QRCode;

constant AUTHOR = ?%*ENV<TEST_AUTHOR>;

if AUTHOR {
  my int32 ($major_version, $minor_version, $micro_version);
  QRcode_APIVersion($major_version, $minor_version, $micro_version);
  is $major_version, '4', 'major version';
  is $minor_version, '0', 'minor version';
  is $micro_version, '2', 'micro version';
  is QRcode_APIVersionString, '4.0.2', 'version string';
}else{
  skip 'major version', 1;
  skip 'minor version', 1;
  skip 'micro version', 1;
  skip 'version string', 1;
}

done-testing;
