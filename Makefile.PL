use 5.006;
use  inc::Module::Install;
license('perl');
WriteMakefile(
    'NAME'		=> 'Text::Quoted',
    'VERSION_FROM'	=> 'Quoted.pm', # finds $VERSION
    'PREREQ_PM'		=> {
        Text::Autoformat => 0,
	Text::Tabs => 0
    }, # e.g., Module::Name => 1.1
      ABSTRACT_FROM => 'Quoted.pm', # retrieve abstract from module
       AUTHOR     => 'Jesse Vincent <jesse@bestpractical.com>'
);
