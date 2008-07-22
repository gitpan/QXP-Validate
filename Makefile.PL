use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'QXP::Validate',
    AUTHOR              => 'Sriram Rajagopalan <rjsri@cpan.org>',
    VERSION_FROM        => 'lib/QXP/Validate.pm',
    ABSTRACT_FROM       => 'lib/QXP/Validate.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'QXP-Validate-*' },
);
