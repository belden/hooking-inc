package KingOfTheINC;

use ForceToHead;

sub import {
	tie @INC, 'ForceToHead', \&tracker, @INC;
}

sub tracker {
	my ($me, $file) = @_;
	warn "looking for $file\n";
	return undef;
}

1;
