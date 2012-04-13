package INCSnooper::Prettier;

use base qw(INCSnooper::Subclassable);

sub decorate {
	my ($class, $depth) = @_;

	my $padding = ('`->') x $depth;
	# $padding =~ s{`->(?=`->)}{   }g;
	return $padding;
}

1;
