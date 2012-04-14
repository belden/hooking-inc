package GenerateCode;

sub import {

	push @INC, sub {
		my ($me, $file) = @_;

		(my $module = $file) =~ s{/}{::}g;
		$module =~ s{\.pm}{};

		my @fake = ("package $module;\n", "1\n");

		return sub {
			$_ = shift @fake;
			return defined $_ ? 1 : 0;
		};
	};
}

1;
