# NAME

Dist::Zilla::Plugin::Prereqs::FromCPANfile - Parse cpanfile for prereqs

# SYNOPSIS

    # dist.ini
    [Prereqs::FromCPANfile]

# DESCRIPTION

Dist::Zilla::Plugin::Prereqs::FromCPANfile is a [Dist::Zilla](http://search.cpan.org/perldoc?Dist::Zilla) plugin
to read _cpanfile_ to determine prerequisites for your distribution. This
does the __opposite of__ what [Dist::Zilla::Plugin::CPANFile](http://search.cpan.org/perldoc?Dist::Zilla::Plugin::CPANFile) does, which
is to _create_ a `cpanfile` using the prereqs collected elsewhere.

__DO NOT USE THIS PLUGIN IN COMBINATION WITH Plugin::CPANFile__. You will
probably be complained about creating duplicate files from dzil.

# AUTHOR

Tatsuhiko Miyagawa <miyagawa@bulknews.net>

# COPYRIGHT

Copyright 2013- Tatsuhiko Miyagawa

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Module::CPANfile](http://search.cpan.org/perldoc?Module::CPANfile)
