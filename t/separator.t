
use Test::More tests => 3;
BEGIN { use_ok('Text::Quoted') };

use Data::Dumper;

my $text = <<EOF;
foo
============
bar
============
baz
EOF

is_deeply(extract($text), [
        {text => 'foo', empty => '', quoter => '', raw => 'foo'},
        {text => '============', empty => '', quoter => '', raw => '============', separator => 1 },
        {text => 'bar', empty => '', quoter => '', raw => 'bar'},
        {text => '============', empty => '', quoter => '', raw => '============', separator => 1 },
        {text => 'baz', empty => '', quoter => '', raw => 'baz'},
    ],
    "Sample text is organized properly"
) or diag Dumper(extract($text));

