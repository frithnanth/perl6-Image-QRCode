use v6;
unit module Image::QRCode:ver<0.0.1>;

use NativeCall;

constant LIB = ('qrencode', v3);

# Encoding mode
enum QRencodeMode is export(:constants) «:QR_MODE_NUL(-1) QR_MODE_NUM QR_MODE_AN QR_MODE_8 QR_MODE_KANJI QR_MODE_STRUCTURE QR_MODE_ECI QR_MODE_FNC1FIRST QR_MODE_FNC1SECOND»;
# Level of error correction
enum QRecLevel is export(:constants) <QR_ECLEVEL_L QR_ECLEVEL_M QR_ECLEVEL_Q QR_ECLEVEL_H>;
# Maximum version (size) of QR-code symbol
constant QRSPEC_VERSION_MAX is export(:constants) = 40;
# Maximum version (size) of QR-code symbol
constant MQRSPEC_VERSION_MAX is export(:constants) = 4;

class QRinput is repr('CPointer') is export { * } # libqrencode private struct
class QRinput_Struct is repr('CPointer') is export { * } # libqrencode private struct

class Image::QRCode::QRcode is repr('CStruct') is export {
  has int32 $.version;
  has int32 $.width;
  has CArray[uint8] $.data;
}
class Image::QRCode::QRcode_List is repr('CStruct') is export {
  has Image::QRCode::QRcode $.code;
  has Image::QRCode::QRcode_List $.next;
}

sub QRinput_new(--> QRinput) is native(LIB) is export { * }
sub QRinput_new2(int32 $version, int32 $level --> QRinput) is native(LIB) is export { * }
sub QRinput_newMQR(int32 $version, int32 $level --> QRinput) is native(LIB) is export { * }
sub QRinput_append(QRinput $input, int32 $mode, int32 $size, Str $data --> int32) is native(LIB) is export { * }
sub QRinput_appendECIheader(QRinput $input, uint32 $ecinum --> int32) is native(LIB) is export { * }
sub QRinput_getVersion(QRinput $input --> int32) is native(LIB) is export { * }
sub QRinput_setVersion(QRinput $input, int32 $version --> int32) is native(LIB) is export { * }
sub QRinput_getErrorCorrectionLevel(QRinput $input --> int32) is native(LIB) is export { * }
sub QRinput_setErrorCorrectionLevel(QRinput $input, int32 $level --> int32) is native(LIB) is export { * }
sub QRinput_setVersionAndErrorCorrectionLevel(QRinput $input, int32 $version, int32 $level --> int32) is native(LIB) is export { * }
sub QRinput_free(QRinput $input) is native(LIB) is export { * }
sub QRinput_check(int32 $mode, int32 $size, Str $data --> int32) is native(LIB) is export { * }
sub QRinput_Struct_new(--> QRinput_Struct) is native(LIB) is export { * }
sub QRinput_Struct_setParity(QRinput_Struct $s, uint8 $parity) is native(LIB) is export { * }
sub QRinput_Struct_appendInput(QRinput_Struct $s, QRinput $input --> int32) is native(LIB) is export { * }
sub QRinput_Struct_free(QRinput_Struct $s) is native(LIB) is export { * }
sub QRinput_splitQRinputToStructQRinput(QRinput $input --> QRinput_Struct) is native(LIB) is export { * }
sub QRinput_Struct_insertStructuredAppendHeaders(QRinput_Struct $s --> int32) is native(LIB) is export { * }
sub QRinput_setFNC1First(QRinput_Struct $s --> int32) is native(LIB) is export { * }
sub QRinput_setFNC1Second(QRinput_Struct $s, Str $appid --> int32) is native(LIB) is export { * }
sub QRcode_encodeInput(QRinput $input --> QRcode) is native(LIB) is export { * }
sub QRcode_encodeString(Str $string, int32 $version, int32 $level, int32 $hint, int32 $casesensitive --> QRcode) is native(LIB) is export { * }
sub QRcode_encodeString8bit(Str $string, int32 $version, int32 $level --> QRcode) is native(LIB) is export { * }
sub QRcode_encodeStringMQR(Str $string, int32 $version, int32 $level, int32 $hint, int32 $casesensitive --> QRcode) is native(LIB) is export { * }
sub QRcode_encodeString8bitMQR(Str $string, int32 $version, int32 $level --> QRcode) is native(LIB) is export { * }
sub QRcode_encodeData(int32 $size, Str $data, int32 $version, int32 $level --> QRcode) is native(LIB) is export { * }
sub QRcode_encodeDataMQR(int32 $size, Str $data, int32 $version, int32 $level --> QRcode) is native(LIB) is export { * }
sub QRcode_free(QRcode $qrcode) is native(LIB) is export { * }
sub QRcode_encodeInputStructured(QRinput_Struct $s --> QRcode_List) is native(LIB) is export { * }
sub QRcode_encodeStringStructured(Str $string, int32 $version, int32 $level, int32 $hint, int32 $casesensitive --> QRcode_List) is native(LIB) is export { * }
sub QRcode_encodeString8bitStructured(Str $string, int32 $version, int32 $level --> QRcode_List) is native(LIB) is export { * }
sub QRcode_encodeDataStructured(int32 $size, Str $data, int32 $version, int32 $level --> QRcode_List) is native(LIB) is export { * }
sub QRcode_List_size(QRcode_List $qrlist --> int32) is native(LIB) is export { * }
sub QRcode_List_free(QRcode_List $qrlist --> int32) is native(LIB) is export { * }
sub QRcode_APIVersion(int32 $major_version is rw, int32 $minor_version is rw, int32 $micro_version is rw) is native(LIB) is export { * }
sub QRcode_APIVersionString(--> Str) is native(LIB) is export { * }
sub QRcode_clearCache() is native(LIB) is export { * }
