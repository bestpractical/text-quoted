use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Text::Quoted',
    'VERSION_FROM'	=> 'Quoted.pm', # finds $VERSION
    'PREREQ_PM'		=> {
        Text::Autoformat => 0
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Quoted.pm', # retrieve abstract from module
       AUTHOR     => 'Simon Cozens <simon@kasei.com>') : ()),
);
