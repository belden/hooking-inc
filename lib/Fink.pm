package Fink;

sub import {
	unshift @INC, sub {
		my ($me, $file_to_load) = @_;
		warn "loading: $file_to_load\n";
	};
	return undef;
}

1;
