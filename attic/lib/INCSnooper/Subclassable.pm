package INCSnooper::Subclassable;

sub import {
	my ($class) = @_;
	unshift @INC, $class->tracker;
}

sub tracker {
	my ($class) = @_;

	return sub {
		my ($me, $file_to_load) = @_;

		my $depth;
		my $lookback = 0;
		while (caller($lookback)) {
			$depth++ if (caller($lookback++))[7];
		}

		my $padding = $class->decorate($depth);
		warn "$padding$file_to_load\n";
		return undef;								# send a "keep looking" message
	};
}

sub decorate {
	my ($class, $depth) = @_;
	my $padding = ('-->') x $depth;
	$padding =~ s{->-}{---}g;
	return $padding;
}

1;
