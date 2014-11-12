#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use String::Tagged::IRC;

# enabled
{
   my $st = String::Tagged::IRC->parse_irc( "A word in *bold* or /italic/",
      parse_plain_formatting => 1,
   );

   is( "$st", "A word in *bold* or /italic/", '"$st" with mIRC-style bold and italic' );
   is_deeply( [ sort $st->tagnames ], [qw( b i )], '$st has b and i tags' );

   is_deeply( $st->get_tags_at( index $st, "bold"   ), { b => 1 }, '$st has b at "bold"' );
   is_deeply( $st->get_tags_at( index $st, "italic" ), { i => 1 }, '$st has i at "italic"' );
}

# disabled
{
   my $st = String::Tagged::IRC->parse_irc( "A word in *bold* or /italic/",
      parse_plain_formatting => 0,
   );

   is( "$st", "A word in *bold* or /italic/", '"$st" with mIRC-style bold and italic' );
   is( scalar $st->tagnames, 0, '$st has no tags' );
}

done_testing;
