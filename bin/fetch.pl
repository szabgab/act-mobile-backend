#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use WWW::Mechanize;
use DateTime;

my $m = WWW::Mechanize->new;

# based on input
my $url = "http://www.yapcna.org/yn2013";
my $day = DateTime->new(year => 2013, month => 6, day => 3);
my $length = 3;

$m->get("$url/timetable.ics");
say $m->content;

#for (1..$length) {
#	#say $day->ymd;
#	$m->get("$url/schedule?day=" . $day->ymd);
#
#	$day->add_duration( DateTime::Duration->new(days => 1) );
#}

