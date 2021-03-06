use LWP::UserAgent;
use File::Compare;
use Text::Diff;
use File::Copy;
$url = 'http://aircure.in/job/opportunities.php';
my $ua = LWP::UserAgent->new;
my $response = $ua->get( $url );
my $filename = 'old.html';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh $response->content if $response->is_success;
close $fh;
print "done\n";
for( ; ; )
{
	$url = 'http://aircure.in/job/opportunities.php';
	my $ua = LWP::UserAgent->new;
	my $response = $ua->get( $url );
	my $filename = 'new.html';
	open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
	print $fh $response->content if $response->is_success;
	close $fh;
	if (compare("new.html","old.html") == 0) {
	    print "They're equal\n";
	}
	else {
		print "Updated\n";
		my $diff = diff "old.html", "new.html", { STYLE => "OldStyle" };
		print $diff;
		copy("new.html","old.html") or die "Copy failed: $!";
	}
	sleep(2);
}
