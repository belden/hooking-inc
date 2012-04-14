package ForceToHead;

sub TIEARRAY {
	my ($class, $force_to_head) = @_;
	return bless {
		inc => [$head, @INC],
		original => [@INC],
		head => $force_to_head,
	}, $class;
}

sub FETCH {
	my ($self, $index) = @_;
	return $self->{inc}[$index];
}

sub STORE {
	my ($self, $index, $value) = @_;
	if ($index == 0) {
		$self->SPLICE(1, 0, $value);
	} else {
		$self->{inc}[$index] = $value;
	}
}

sub FETCHSIZE {
	my ($self) = @_;
	return scalar @{$self->{inc}} + 1;
}

sub STORESIZE {
	my $self  = shift;
	my $count = shift;
	if ( $count > $self->FETCHSIZE() ) {
		foreach ( $count - $self->FETCHSIZE() .. $count ) {
			$self->STORE( $_, '' );
		}
	} elsif ( $count < $self->FETCHSIZE() ) {
		foreach ( 0 .. $self->FETCHSIZE() - $count - 2 ) {
			$self->POP();
		}
	}
}

sub EXTEND {}
sub EXISTS {
	my ($self, $index) = @_;
	return defined $self->{inc}[$index];
}

sub DELETE {
	my ($self, $index) = @_;
	delete $self->{inc}[$index];
}

sub CLEAR {
	my ($self) = @_;
	$self->{inc} = [];
}

sub PUSH {
	my ($self, @list) = @_;
	push @{$self->{inc}}, @list;
}

sub POP {
	my $self = shift;
	return pop @{$self->{inc}};
}

sub SHIFT {
	my $self = shift;
	return shift @{$self->{inc}};
}

sub UNSHIFT {
	my $self = shift;
	unshift @{$self->{inc}}, @_;
}

sub SPLICE {
	my $self = shift;
	splice @{$self->{inc}}, @_;
}

1;
