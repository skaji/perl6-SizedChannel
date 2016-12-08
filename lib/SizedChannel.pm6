use v6;
unit class SizedChannel;

has $.size is required;
has $!channel = Channel.new;
has $!notify = Channel.new;
has $!lock = Lock.new;
has $!c = 0;

method send(\x) {
    loop {
        $!lock.protect: {
            if $!c < $!size {
                $!c++;
                return $!channel.send(x);
            }
        }
        $!notify.receive;
        $!lock.protect: { $!c-- };
    }
}

method receive {
    my \x = $!channel.receive;
    $!notify.send(Nil);
    return x;
}


=begin pod

=head1 NAME

SizedChannel - Channel with limit queue size

=head1 SYNOPSIS

=begin code :info<perl6>

use SizedChannel;

my $channel = SizedChannel.new(size => 5);

for 1..10 {
    print "[$_] sending...";
    $c.send(Nil);
    print " done\n";
}

# > perl6 synopsis.p6
# [1] sending... done
# [2] sending... done
# [3] sending... done
# [4] sending... done
# [5] sending... done
# [6] sending...       # blocking

=end code

=head1 DESCRIPTION

As you know, perl6's Channel does not have
a limit on the number of items that may be queued.

On the other hand, SizedChannel allows you to create Channel with limit queue size.

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Shoichi Kaji

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
