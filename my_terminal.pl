use Term::ReadLine;

my %variables = ();

my %commands = (
    exit => {
        doc => {
            args => '',
            short_desc => 'Exit the terminal',
        },
        action => sub {
            last;
        },
    },
    help => {
        doc => {
            args => '',
            short_desc => 'Print the help text',
        },
        action => sub {
            print_help_text();
        },
    },
    set => {
        doc => {
            args => '<key> <value>',
            short_desc => 'Set key/value pair, which can be later used in command line like $<key>',
        },
        action => sub {
            my $cmd = shift;
            my ($cmd_name, @cmd_args) = split(' ', $cmd);
            if(scalar @cmd_args != 2) { print('Must supply 2 arguments to set command'); return; }
            $variables{$cmd_args[0]} = $cmd_args[1];
        },
    },
    get => {
        doc => {
            args => '[<key>]',
            short_desc => 'Get value for the given <key>, if <key> missing return all key/value pairs',
        },
        action => sub {
            my $cmd = shift;
            my ($cmd_name, @cmd_args) = split(' ', $cmd);
            if(scalar @cmd_args == 1) { print("$variables{$cmd_args[0]}\n"); }
            else {
                for my $key (sort keys %variables) {
                    print("$key => $variables{$key}\n");
                }
            }
        },
    },
    unset => {
        doc => {
            args => '[<key>]',
            short_desc => 'Remove key/value pair for the given <key>, if <key> missing remove all key/value pairs',
        },
        action => sub {
            my $cmd = shift;
            my ($cmd_name, @cmd_args) = split(' ', $cmd);
            if(scalar @cmd_args == 1) { delete $variables{$cmd_args[0]}; }
            else {
                %variables = ();
            }
        },
    },
);

my $term = Term::ReadLine->new('My Terminal');
$term->ornaments(0);    # Remove underline from promt string
while(1){
    my $cmd = $term->readline('>> ');
    $cmd = expand_variables($cmd);
    my ($cmd_name, @cmd_args) = split(' ', $cmd);
    if(exists $commands{$cmd_name}) {
        $commands{$cmd_name}->{action}->($cmd);
    }
    else {
	    system($cmd);
    }
}

sub expand_variables {
    my $cmd = shift;
    for my $key (reverse sort keys %variables) {
        $cmd =~ s/\$\Q$key\E/$variables{$key}/gc;
    }
    return $cmd;
}

sub print_help_text {
    for my $cmd_name (sort keys %commands) {
        my $help_text = "$cmd_name $commands{$cmd_name}{doc}{args}\n\t$commands{$cmd_name}{doc}{short_desc}\n";
        print($help_text);
    }
    return;
}

