package Indented;

sub import {
	unshift @INC, sub {
		my ($me, $file) = @_;

		my ($indent, $frames);
		while (caller($frames)) {
			$indent .= '-->' if (caller($frames++))[7];
		}

		warn "$indent$file\n";
		return undef;
	}
}

1;
