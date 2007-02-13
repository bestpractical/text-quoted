use strict;
use warnings;
use Text::Quoted;
use Test::More tests => 5;

#########################
# handle nested comments with common >
my $a = <<EOF;
> a
>> b
> c
EOF

my $a_data = 
    [
       [ 
         { 'text' => 'a', 'empty' => '', 'quoter' => '>', 'raw' => '> a' },
         [ { 'text' => 'b', 'empty' => '', 'quoter' => '>>', 'raw' => '>> b' } ],
         { 'text' => 'c', 'empty' => '', 'quoter' => '>', 'raw' => '> c' }
       ]
    ];

is_deeply(extract($a),$a_data,"correctly parse >> delimiter");

#############
# when the quoter changes in the middle of things, don't get confused

$a = <<EOF;
> a
=> b
> c
EOF

$a_data = 
    [
       [ { 'text' => 'a', 'empty' => '', 'quoter' => '>', 'raw' => '> a' } ],
       [ { 'text' => 'b', 'empty' => '', 'quoter' => '=>', 'raw' => '=> b' } ],
       [ { 'text' => 'c', 'empty' => '', 'quoter' => '>', 'raw' => '> c' } ]
    ];

is_deeply(extract($a),$a_data,"correctly parse => delimiter");

#############
# when the quoter changes in the middle of things, don't get confused
# blank lines shouldn't affect it

$a = <<EOF;
> a

=> b

> c
EOF

$a_data = 
    [
       [ { 'text' => 'a', 'empty' => '', 'quoter' => '>', 'raw' => '> a' } ],
       { 'text' => '', 'empty' => 1, 'quoter' => '', 'raw' => '' },
       [ { 'text' => 'b', 'empty' => '', 'quoter' => '=>', 'raw' => '=> b' } ],
       { 'text' => '', 'empty' => 1, 'quoter' => '', 'raw' => '' },
       [ { 'text' => 'c', 'empty' => '', 'quoter' => '>', 'raw' => '> c' } ]
    ];

is_deeply(extract($a),$a_data,"correctly parse => delimiter with blank lines");

#############
# one of the real world quoter breakage examples was cpan>
# also, no text is required for the quoter to break things

$a = <<EOF;
>
cpan>
>
EOF

$a_data = 
    [
       [ { 'text' => '', 'empty' => 1, 'quoter' => '>', 'raw' => '>' } ],
       [ { 'text' => '', 'empty' => 1, 'quoter' => 'cpan>', 'raw' => 'cpan>' } ],
       [ { 'text' => '', 'empty' => 1, 'quoter' => '>', 'raw' => '>' } ]
    ];

is_deeply(extract($a),$a_data,"correctly parse cpan> delimiter with no text");

############
# just checking that when the cpan> quoter gets a space, we handle it properly

$a = <<EOF;
> a
cpan > b
> c
EOF

$a_data = 
    [
       [ { 'text' => 'a', 'empty' => '', 'quoter' => '>', 'raw' => '> a' } ],
       { 'text' => 'cpan > b', 'empty' => '', 'quoter' => '', 'raw' => 'cpan > b' },
       [ { 'text' => 'c', 'empty' => '', 'quoter' => '>', 'raw' => '> c' } ],
    ];

is_deeply(extract($a),$a_data,"correctly handles a non-delimiter");
