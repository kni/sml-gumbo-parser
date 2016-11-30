$| = 1;
use v5.10;
use strict;
use warnings;


my @nodes = qw/document element text cdata comment whitespace template/;
my @tags = map { chomp; $_ } <DATA>;



sub _fun_for_type_from {
	my ($fun, $type, $v) = @_;

	my $t = ucfirst($type) . join "", map { ucfirst } split /-/, $v;
	my $ct = "GUMBO_" . uc($type) . "_" . uc($v);
	$ct =~ s/-/_/g;

	qq/\tprintf("  $fun \%zi = $t\\n", $ct);\n/;
}

sub fun_for_type_from {
	my $fun  = shift;
	my $type = shift;

	my @r = ();
	push @r, _fun_for_type_from("fun $fun", $type, shift);
	push @r, _fun_for_type_from("  | $fun", $type, $_) foreach @_;
	push @r, qq/\tprintf("    | $fun _ = raise Gumbo \\\"$fun\\\"\\n");\n/;

	return @r;
}


{
my $fn  = "gumbo-common.sig";
open my $fh, ">", $fn or die "Cannot open '$fn' file: $!";

print $fh <<EOD;
(* Generated, do not edit. *)
signature GUMBO_COMMON =
sig
  exception Gumbo of string

EOD


my @Nodes = map {  ucfirst $_ } @nodes;
print $fh "  datatype NodeType = ", join "                    | ", map { "Node$_\n" } @Nodes;
print $fh "\n";

my @Tags = map { (join "", map { ucfirst } split /-/, $_) } @tags;
print $fh "  datatype TagName = ", join "                   | ",  map { "Tag$_\n" } @Tags;
print $fh "\n";

print $fh <<EOD;
  val showNodeType: NodeType -> string
  val showTagName:  TagName  -> string
end
EOD
close $fn;
}

{
my $fn  = "gumbo-common.sml";
open my $fh, ">", $fn or die "Cannot open '$fn' file: $!";

print $fh <<EOD;
(* Generated, do not edit. *)
structure GumboCommon : GUMBO_COMMON =
struct
  exception Gumbo of string

EOD

my @Nodes = map {  ucfirst $_ } @nodes;
print $fh "  datatype NodeType = ", join "                    | ", map { "Node$_\n" } @Nodes;
print $fh "\n";
print $fh "  fun", join "    |", map { " showNodeType Node$_ = \"$_\"\n" } @Nodes;
print $fh "\n";

my @Tags = map { (join "", map { ucfirst } split /-/, $_) } @tags;
print $fh "  datatype TagName = ", join "                   | ",  map { "Tag$_\n" } @Tags;
print $fh "\n";
print $fh "  fun", join "    |", map { " showTagName Tag$_ = \"$_\"\n" } @Tags;
print $fh "\n";

print $fh "end\n";
close $fn;
}



{
my $fn = "gumbo-constants.c";
open my $fh, ">", $fn or die "Cannot open '$fn' file: $!";

print $fh <<'EOD';
// Generated, do not edit.
#include <stdio.h>
#include <stddef.h>
#include "gumbo.h"

int main () {
	printf("(* Generated, do not edit. *)\n");
	printf("structure GumboConstants =\n");
	printf("struct\n");
	printf("  open GumboCommon\n");

	printf("  val offsetof_ActualNodeData = %zu\n", offsetof(struct GumboInternalNode, v));
	printf("  val offsetof_ElementTag = %zu\n", offsetof(GumboElement, tag));
	printf("  val offsetof_ElementAttributes = %zu\n", offsetof(GumboElement, attributes));
	printf("  val offsetof_GumboAttributeName = %zu\n", offsetof(GumboAttribute, name));
	printf("  val offsetof_GumboAttributeValue = %zu\n", offsetof(GumboAttribute, value));

EOD

print $fh fun_for_type_from "nodeTypeFromInt", "node", @nodes;

print $fh fun_for_type_from "tagTypeFromInt", "tag", @tags;

print $fh <<'EOD';

	printf("end\n");

	// printf("\n(*\n");
	// printf("  val sizeof_GumboNodeType = %zu\n", sizeof(GumboNodeType));
	// printf("*)\n");

	return 0;
}
EOD

close $fh;
}


# from gumbo-parser/src/tag.in
__DATA__
html
head
title
base
link
meta
style
script
noscript
template
body
article
section
nav
aside
h1
h2
h3
h4
h5
h6
hgroup
header
footer
address
p
hr
pre
blockquote
ol
ul
li
dl
dt
dd
figure
figcaption
main
div
a
em
strong
small
s
cite
q
dfn
abbr
data
time
code
var
samp
kbd
sub
sup
i
b
u
mark
ruby
rt
rp
bdi
bdo
span
br
wbr
ins
del
image
img
iframe
embed
object
param
video
audio
source
track
canvas
map
area
math
mi
mo
mn
ms
mtext
mglyph
malignmark
annotation-xml
svg
foreignobject
desc
table
caption
colgroup
col
tbody
thead
tfoot
tr
td
th
form
fieldset
legend
label
input
button
select
datalist
optgroup
option
textarea
keygen
output
progress
meter
details
summary
menu
menuitem
applet
acronym
bgsound
dir
frame
frameset
noframes
isindex
listing
xmp
nextid
noembed
plaintext
rb
strike
basefont
big
blink
center
font
marquee
multicol
nobr
spacer
tt
rtc
unknown
last
