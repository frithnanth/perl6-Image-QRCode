## Image::QRCode

Image::QRCode - OO interface to libqrencode.

## Build Status

| Operating System  |   Build Status  | CI Provider |
| ----------------- | --------------- | ----------- |
| Linux             | [![Build Status](https://travis-ci.org/frithnanth/perl6-Image-QRCode.svg?branch=master)](https://travis-ci.org/frithnanth/perl6-Image-QRCode)  | Travis CI |

## Example

```Perl6
use v6;

use Image::QRCode;
use Image::QRCode::Constants;

```

For more examples see the `example` directory.

## Description

Image::QRCode provides an interface to libqrencode.


## Documentation

## Prerequisites
This module requires the libqrencode3 library to be installed. Please follow
the instructions below based on your platform:

### Debian Linux

```
sudo apt-get install libqrencode3
```

## Installation

To install it using zef (a module management tool):

```
$ zef update
$ zef install Image::QRCode
```

## Testing

To run the tests:

```
$ prove -e "perl6 -Ilib"
```

## Note

Image::QRCode relies on a C library which might not be present in one's
installation, so it's not a substitute for a pure Perl6 module.

## Author

Fernando Santagata

## Copyright and license

The Artistic License 2.0
