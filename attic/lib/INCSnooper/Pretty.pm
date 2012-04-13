package INCSnooper::Pretty;

sub import {
	unshift @INC, \&tracker;
}

sub tracker {
	 my ($me, $file_to_load) = @_;

	 my $padding = '';
	 my $lookback = 0;
	 while (caller($lookback)) {
		 $padding .= "-->" if (caller($lookback++))[7];
	 }

	 $padding =~ s{->-}{---}g;
	 warn "$padding$file_to_load\n";
	 return undef;		# send a "keep looking" message
}

1;
