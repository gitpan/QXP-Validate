package QXP::Validate;

=head1 NAME

QXP::Validate

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

When the strict XML is not used, parsers will not be helpful in validating the document instance. Also, developing a Document type definition for simple markup will not be effective. This module performs the basic functions like validating the inline and stand-alone elements, checking for non-ASCII character in the file, check for dummy characters, check for unintentional key press etc.


    use QXP::Validate;

    my $foo = QXP::Validate->new();
    ...

=head1 FUNCTIONS

=head2 Parseinline

Will check the presence of the start and end tags for all the inline elements like Italic, Bold etc. All the tags started in the line needs to be closed within the same line. Run this function on a string of text. This will be useful, when you are reading line by line through a file. $stag gives you the number of occurrences for the start tag and $etag gives you the number of occurrences for the end tags.

QXP::Validate->parseinline("i");

=head2 Parsetag

When you are reading through line by line in a file, this function will store the start and the end tags and increament the counter used for both. Once you have finished reading through the elements, examine the count of $first_parameter. If every opening tag has its respective close tag, the count will be 0. If the value of the variable is >1, it means there are less closing tags than opening tags, on the other hand, if the value is <1 there are less opening tags than closing tags. Call this function using one parameter. The parameter is the tag name which need to be examined.

QXP::Validate->parsetag("bl");

=head2 Filter Non-ASCII characters

Will parse through the file to check whether any non-ASCII characters are present in the file. In a ASCII file, if there are any binary characters found, the function will report a error on the screen and will quit the execution.

QXP::Validate->chk_nonascii();

=head2 Unintentional Characters

Will check and report if any character if found repeating more than three times sequentially in a file. When working on a file, if the keyboarder inserts a series of characters unintentionally, they will be reported as errors.

QXP::Validate->chk_seq();

=head2 Dummy tags

In the text file, if there are any elements starting and closing without any content to it, this function will report a error for that.

QXP::Validate->chk_dummy();


=head1 AUTHOR

Sriram Rajagopalan, C<< <rjsri at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-qxp-validate at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=QXP-Validate>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc QXP::Validate

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/QXP-Validate>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/QXP-Validate>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=QXP-Validate>

=item * Search CPAN

L<http://search.cpan.org/dist/QXP-Validate>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2008 Sriram Rajagopalan, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

sub parsetag
{
	if($str =~ /<$_[0]>/g){${$_[0]}++}
	if($str =~ /<\/$_[0]>/g){${$_[0]}--}
}

sub parseinline
{
	my $stag=0;
	my $etag=0;
	while ($str =~ /<$_[0]>/g){$stag++}
	while ($str =~ /<\/$_[0]>/g){$etag++}
	if ($stag != $etag){print "Ln# $.: Mismatch between start and end element for '<$_[0]>' in $ARGV[0].\nStart tag(s): $stag \nEnd tag(s): $etag \n"};
}

sub chk_nonascii()
{
	while (my $str =~ /[^!-~\s]/g) 
	{
		print "*" x 50;
		print "\n\nERROR: Non-ASCII Character $& found in $ARGV[0].\nXML not produced/produced with errors. Fix the error and re-run the cleanup\n\n";
		print "*" x 50;
	exit;

	}
}

sub chk_seq()
{
	while($str =~ /(.)\1\1\1/g){print "Character '$1' found repeating several times in the text.\nPossibility of a typographic error or a sequence of unintentional key press."}
}

sub chk_dummy
{
	if($str =~ /<([^\/ >]+)( [^>]+)?><\/\1>/gs) {print "Element with no content '$&' found in $ARGV[0].\nRemove if this is unnecessary and re-run the conversion"};
}

1; # End of QXP::Validate
