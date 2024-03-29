[![Actions Status](https://github.com/frithnanth/perl6-Image-QRCode/workflows/test/badge.svg)](https://github.com/frithnanth/perl6-Image-QRCode/actions)

NAME
====

Image::QRCode - An interface to libqrencode.

SYNOPSIS
========

```raku
use Image::QRCode;

my $code = Image::QRCode.new.encode('https://raku.org/');
my $dim = $code.qrcode.width;
my @array2D[$dim;$dim] = $code.get-data(2);
say @array2D.shape;
say @array2D;
my @array1D = $code.get-data(1);
say @array1D;
```

```raku
use Image::QRCode;

Image::QRCode.new.encode('https://raku.org/').termplot;
```

For more examples see the *example* directory.

DESCRIPTION
===========

Image::QRCode provides an interface to libqrencode and allows you to generate a QR Code.

METHODS
=======

new(Int :$.version, Int :$.level, Int :$.mode, Int :$.casesensitive, Int :$.size)
---------------------------------------------------------------------------------

Creates an **Image::QRCode** object. It may take a list of optional arguments.

The optional argument **$version** defaults to 0 (auto-select). The maximum version value is 4.

The optional argument **$level** defaults to QR_ECLEVEL_L. The list of possible values for this argument is provided by the **QRecLevel** enum:

  * QR_ECLEVEL_L # lowest

  * QR_ECLEVEL_M

  * QR_ECLEVEL_Q

  * QR_ECLEVEL_H # highest

The optional argument **$mode** defaults to QR_MODE_8. The list of possible values for this argument is provided by the **QRencodeMode** enum:

  * QR_MODE_NUL # Terminator (NUL character). Internal use only

  * QR_MODE_NUM # Numeric mode

  * QR_MODE_AN # Alphabet-numeric mode

  * QR_MODE_8 # 8-bit data mode

  * QR_MODE_KANJI # Kanji (shift-jis) mode

  * QR_MODE_STRUCTURE # Internal use only

  * QR_MODE_ECI # ECI mode

  * QR_MODE_FNC1FIRST # FNC1, first position

  * QR_MODE_FNC1SECOND # FNC1, second position

The optional argument **$casesensitive** defaults to True.

The optional argument **$size** defaults to 2. This argument is used only when generating a character based plot of the QR code to adjust the relative proportion of width vs. height.

All these arguments can be accessed directly for both reading and writing:

```raku
my Image::QRCode $code .= new;
$code.casesensitive = False;
```

encode(Str $text!, Int :$version, Int :$level, Int :$mode, Int :$casesensitive)
-------------------------------------------------------------------------------

Encodes a string. It takes one *mandatory* argument: **text**, the string to encode. All the other arguments are optional.

This method put a QR code in the attribute **qrcode**, an object of class QRcode, which can be read directly or managed by other methods.

The class **QRcode** is an interface to the library's internal structure of a QR code. It has three attributes:

  * int32 $.version

  * int32 $.width

  * CArray[uint8] $.data

Even if the **data** attribute can be accessed directly, its representation is a bit complex and most of the coded information is not very useful. The original library's documentation goes as follows:

    Symbol data is represented as an array contains width*width uchars.
    Each uchar represents a module (dot). If the less significant bit of
    the uchar is 1, the corresponding module is black. The other bits are
    meaningless for usual applications, but here its specification is described.

    MSB 76543210 LSB
        |||||||`- 1=black/0=white
        ||||||`-- data and ecc code area
        |||||`--- format information
        ||||`---- version information
        |||`----- timing pattern
        ||`------ alignment pattern
        |`------- finder pattern and separator
        `-------- non-data modules (format, timing, etc.)

    * get-data($dimension)

This method returns the QR code data, encoded as a 1D or 2D array. The argument **dimension** can be 1 or 2: passing a dimension = 1 the method returns a linear array of the values of all the dots, coded as 0 (black) or 1 (white). A value of 2 makes the method return an array of arrays.

    * termplot(Int :$size)

This method accepts the optional parameter **size**, which determines the orizontal stretch of the "image". It prints the QR code on the terminal screen as `\c[FULL BLOCK]` characters. It returns a Failure object if there's no data to plot.

LOW LEVEL CALLS
===============

This module provides an interface to all the C library's functions. The library's full documentation can be found here:

[https://fukuchi.org/works/qrencode/manual/index.html](https://fukuchi.org/works/qrencode/manual/index.html)

Its GitHub page is:

[https://github.com/fukuchi/libqrencode](https://github.com/fukuchi/libqrencode)

When using the low level calls, keep in mind that old versions of the library may lack some functionality:

  * pre v3.2.1 (2012) have no way to query the API version.

  * pre 2010-01-27 versions lack full ECI support (QRinput_encodeModeECI(), QRinput_appendECIheader(), QRinput_estimateBitsModeECI()).

  * pre 2010-01-16 versions have no QRcode_encodeDataMQR() and QRcode_encodeDataStructured() calls.

Prerequisites
=============

This module requires the libqrencode4 library to be installed. In case one has any API-compatible version, this module also reads the dynamically-assigned environment variable RAKU_QRENCODE_LIB. For example:

    RAKU_QRENCODE_LIB=libqrencode.so.3 ./program.raku

For the installation please follow the instructions below, based on your platform:

Debian Linux
------------

    sudo apt-get install libqrencode4

Installation
============

    $ zef install Image::QRCode

Testing
=======

To run the tests:

    $ prove -e "raku -Ilib"

Author
======

Fernando Santagata

License
=======

The Artistic License 2.0

