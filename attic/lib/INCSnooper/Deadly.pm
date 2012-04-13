package INCSnooper::Deadly;

sub import {
	unshift @INC, \&tracker;
}

sub tracker {
	my ($me, $file_to_load) = @_;

	my $padding = '';
	my $lookback = 0;
	$padding .= '.' while caller($lookback++);

	printlog("$padding$file_to_load\n");
	print   ("$padding$file_to_load\n");
	die;

	return undef;		# send a "keep looking" message
}

sub printlog {
my $message = shift;
open my $log, '>>', '/tmp/die';
print $log $message;
close $log;
}

sub show {
	my ($frames) = @_;
	return join "\n", map { join "      ", @$_[0..3] } @$frames;
}

1;
