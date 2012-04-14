package ForceToHead;

sub TIEARRAY {
	my ($class, $head, @body) = @_;
	return bless {
		body => [@body],
		head => $head,
	}, $class;
}

sub FETCH {
	my ($self, $index) = @_;
	return ($self->{head}, @{$self->{body}})[$index];
}

sub STORE {
	my ($self, $index, $value) = @_;
	$self->{body}[$index] = $value;
}

sub FETCHSIZE {
	my ($self) = @_;
	return scalar @{$self->{body}} + 1;
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
	return defined $self->{body}[$index];
}

sub DELETE {
	my ($self, $index) = @_;
	delete $self->{body}[$index];
}

sub CLEAR {
	my ($self) = @_;
	$self->{body} = [];
}

sub PUSH {
	my ($self, @list) = @_;
	push @{$self->{body}}, @list;
}

sub POP {
	my $self = shift;
	return pop @{$self->{body}};
}

sub SHIFT {
	my $self = shift;
	return shift @{$self->{body}};
}

sub UNSHIFT {
	my $self = shift;
	unshift @{$self->{body}}, @_;
}

sub SPLICE {
	my $self = shift;
	splice @{$self->{body}}, @_;
}

1;
