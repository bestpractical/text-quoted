# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('Text::Quoted') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

$a = <<EOF;
> foo
> # Bar
> baz

quux
EOF

is_deeply(extract($a),
[[{text => 'foo',quoter => '>',raw => '> foo'},
  [{text => 'Bar',quoter => '> #',raw => '> # Bar'}],
  {text => 'baz',quoter => '>',raw => '> baz'}
 ],
 {text => '',empty => '1',quoter => '',raw => ''},
 {text => 'quux',quoter => '',raw => 'quux'}],
"Sample text is organized properly");

$b = <<EOF;

> foo
> > > baz
> > quux
> quuux
quuuux
EOF

$b_dump = 
[
      { text => '', empty => '1', quoter => '', raw => '' },
      [
        { text => 'foo', quoter => '>', raw => '> foo' },
        [
          [
            { text => 'baz', quoter => '> > >',
              raw => '> > > baz' }
          ],
          { text => 'quux', quoter => '> >', raw => '> > quux' }
        ],
        { text => 'quuux', quoter => '>', raw => '> quuux' }
      ],
      { text => 'quuuux', quoter => '', raw => 'quuuux' }
    ];


is_deeply(extract($b), $b_dump, "Skipping levels works OK");
