use 5.006;
use inc::Module::Install;

name        'Text-Quoted';
license     'perl';
author       'Jesse Vincent <jesse@bestpractical.com>';

all_from    'Quoted.pm';

requires    'Text::Autoformat';

WriteAll;
