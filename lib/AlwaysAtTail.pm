package AlwaysAtTail;

sub import {
	push @INC, sub {
		my ($me, $file) = @_;
		@INC = grep { "$_" ne "$me" } @INC;
		push @INC, $me;
		warn "failed to load $file, kaboom!\n";
	}
}
1;
