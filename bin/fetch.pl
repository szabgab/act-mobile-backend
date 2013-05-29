#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use WWW::Mechanize;
use DateTime;
use Data::ICal;
use Data::Dumper qw(Dumper);

use Getopt::Long qw(GetOptions);

my%opt;
GetOptions(\%opt,
	'fetch',
	'process',
);

# based on input
my $url = "http://www.yapcna.org/yn2013";
my $day = DateTime->new(year => 2013, month => 6, day => 3);
my $length = 3;

mkdir 'tmp';
my $ics = 'tmp/timetable.ics';

if ($opt{fetch}) {
	my $m = WWW::Mechanize->new;
	$m->get("$url/timetable.ics");
	open my $fh, '>:encoding(utf-8)', $ics;
	print $fh $m->content;
	close $fh;
	exit;
}
if ($opt{process}) {
	die "Missing $ics,  maybe --fetch first?\n" if not -e $ics;
	my $calendar = Data::ICal->new( filename => $ics );
	print $calendar;

	foreach my $e (@{ $calendar->entries }) {
		my $p = $e->properties;
		print Dumper $p;
		exit;
	}

#for (1..$length) {
#	#say $day->ymd;
#	$m->get("$url/schedule?day=" . $day->ymd);
#
#	$day->add_duration( DateTime::Duration->new(days => 1) );
#}
	exit;
}

die "Usage: $0 [--fetch|--process]\n";

