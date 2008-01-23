use strict;
use Test::More tests => 2;
BEGIN { use_ok('Text::Quoted') };

eval { require Encode } or skip_all("No Encode module");
$a = Encode::decode_utf8("x\303\203 \tz");

is_deeply( extract($a), [ { 
    text   => Encode::decode_utf8("x\303\203      z"),
    empty  => '',
    quoter => '',
    raw    => Encode::decode_utf8("x\303\203      z"),
} ], "No segfault");
