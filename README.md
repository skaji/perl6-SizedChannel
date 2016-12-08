[![Build Status](https://travis-ci.org/skaji/perl6-SizedChannel.svg?branch=master)](https://travis-ci.org/skaji/perl6-SizedChannel)

NAME
====

SizedChannel - Channel with limit queue size

SYNOPSIS
========

```perl6
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
```

DESCRIPTION
===========

As you know, perl6's Channel does not have a limit on the number of items that may be queued.

On the other hand, SizedChannel allows you to create Channel with limit queue size.

AUTHOR
======

Shoichi Kaji <skaji@cpan.org>

COPYRIGHT AND LICENSE
=====================

Copyright 2016 Shoichi Kaji

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
