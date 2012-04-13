package INCSnooper;

sub import {
	unshift @INC, \&tracker;
}

sub tracker {
	 my ($me, $file_to_load) = @_;

	 warn "want to load: $file_to_load\n";

	 return undef;		# send a "keep looking" message
}

1;
