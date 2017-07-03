package Dist::Zilla::Plugin::Prereqs::FromCPANfile;

use strict;
our $VERSION = '0.08';

use Module::CPANfile;
use Try::Tiny;
use Moose;
with 'Dist::Zilla::Role::PrereqSource', 'Dist::Zilla::Role::MetaProvider';

has cpanfile => (is => 'ro', lazy => 1, builder => '_build_cpanfile');

sub _build_cpanfile {
    my $self = shift;

    return unless -e 'cpanfile';

    try {
        $self->log("Parsing 'cpanfile' to extract prereqs");
        Module::CPANfile->load;
    } catch {
        $self->log_fatal($_);
    };
}

sub register_prereqs {
    my $self = shift;

    my $cpanfile = $self->cpanfile or return;

    my $prereqs = $cpanfile->prereq_specs;
    for my $phase (keys %$prereqs) {
        for my $type (keys %{$prereqs->{$phase}}) {
            $self->zilla->register_prereqs(
                { type => $type, phase => $phase },
                %{$prereqs->{$phase}{$type}},
            );
        }
    }
}

sub metadata {
    my $self = shift;

    my $cpanfile = $self->cpanfile     or return {};
    my @features = $cpanfile->features or return {};

    my $features = {};

    for my $feature (@features) {
        $features->{$feature->identifier} = {
            description => $feature->description,
            prereqs => $feature->prereqs->as_string_hash,
        }
    }

    return { optional_features => $features };
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;
__END__

=encoding utf-8

=for stopwords

=head1 NAME

Dist::Zilla::Plugin::Prereqs::FromCPANfile - Parse cpanfile for prereqs

=head1 SYNOPSIS

  # dist.ini
  [Prereqs::FromCPANfile]

=head1 DESCRIPTION

Dist::Zilla::Plugin::Prereqs::FromCPANfile is a L<Dist::Zilla> plugin
to read I<cpanfile> to determine prerequisites for your distribution. This
does the B<opposite of> what L<Dist::Zilla::Plugin::CPANFile> does, which
is to I<create> a C<cpanfile> using the prereqs collected elsewhere.

When C<feature> DSL is used in C<cpanfile>, it will correctly be
converted to C<optional_features> in META data.

B<DO NOT USE THIS PLUGIN IN COMBINATION WITH Plugin::CPANFile>. You will
probably be complained about creating duplicate files from dzil.

=head1 MIGRATION

If you are migrating an existing Dist::Zilla configuration to be using
and F<cpanfile> and this plugin, you can do the following to ease the
proces and let L<Dist::Zilla> auto-generate your initial F<cpanfile> so you do
not have to write it by hand.

Add the following line to your F<dist.ini>

    # dist.ini
    [CPANFile]

Using L<Dist::Zilla::Plugin::CPANFile>, which is included with L<Dist::Zilla> we
can now generate the F<cpanfile> based on the prerequisites specified in F<dist.ini>.

    # build
    $ dzil build

    # copy the newly generate cpanfile
    $ cp <distribution build dir>/cpanfile .

    # change the line in your dist.ini from:
    [CPANFile]

    # to:
    [Prereqs::FromCPANfile]

Now you have auto-generated F<cpanfile> and you can delete the prerequisites
sections from your F<dist.ini> and your prerequisites are now listed in your
F<cpanfile> and can be maintained here.

Using the newly generated F<cpanfile>, of course requires the installation of this
plugin.

As previously noted the two plugins are not meant to be used at the same time, but
for this initial migration they can supplement each other.

=head1 AUTHOR

Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

=head1 COPYRIGHT

Copyright 2013- Tatsuhiko Miyagawa

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Module::CPANfile>

L<Dist::Zilla>

L<Dist::Zilla::Plugin::CPANFile>

=cut
