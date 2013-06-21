# == WHAT
# Respond to words that rhyme with "Flash".
#
# == WHO
# Jan Moesen, 2012
#
# == INSTALL
# Save it in ~/.irssi/scripts/ and do /script load a_ahspam.pl
# OR
# Save it in ~/.irssi/scripts/autorun and (re)start Irssi

use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = '0.1';
%IRSSI = (
	authors     => 'Jan Moesen',
	name        => 'A-ahSpam',
	description => 'Respond to words that rhyme with "Flash".',
	license     => 'GPL',
	url         => 'http://jan.moesen.nu/',
	changed     => 'Wed Jun 06 15:15:07 +0200 2012',
);

sub a_ahspam_process_message {
	my ($server, $msg, $target) = @_;
	return if int(rand() * 5);

	return unless $target =~ /^#(catena|lolwut)/;
	return unless $msg =~ m/\b(ash|bash|brash|cache|cash|clash|crash|dash|flash|gash|gnash|hache|hash|lash|mash|rash|sash|slash|smash|splash|stache|stash|thrash|trash)\b/i;

	my $message = "\"$1, a-ah, saviour of the universe!\"";
	return if $msg eq $message;

	$server->command("msg $target $message");
}

Irssi::signal_add_last('message public', sub {
	my ($server, $msg, $nick, $mask, $target) = @_;
	Irssi::signal_continue($server, $msg, $nick, $mask, $target);
	a_ahspam_process_message($server, $msg, $target);
});
Irssi::signal_add_last('message own_public', sub {
	my ($server, $msg, $target) = @_;
	Irssi::signal_continue($server, $msg, $target);
	a_ahspam_process_message($server, $msg, $target);
});
