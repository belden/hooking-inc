package Peeker;

my %cache;

sub import {
	unshift @INC, sub {
		my ($me, $file) = @_;

		# find where in @INC $file really lives
		my ($found) = grep { -f "$_/$file" } @INC[1..$#INC];
		return unless $found;

		(my $module = $file) =~ s{/}{::}g;
		$module =~ s{.pm}{};

		open my $fh, '<', "$found/$file" or die "$found/$file: $!\n";

		while (<$fh>) {
			chomp;
			# warning, lame perl parsing ahead
			if ($_ =~ m{use ([\w:]+)}) {
				$cache{$module}{loads}{$1} = 1;
				$cache{$1}{loaded_by}{$module} = 1;
			}
		}

		seek($fh,0,0);
		return ($fh);
	}
}

END {
	foreach my $module (keys %cache) {
		print "$module:\n";
		print "\tloads: \n" . join "\n", map { "\t\t$_" } keys %{$cache{$module}{loads}};
		print "\n";
		print "\tloaded by:\n" . join "\n", map { "\t\t$_" } keys %{$cache{$module}{loaded_by}};
		print "\n";
	}
}

1;
