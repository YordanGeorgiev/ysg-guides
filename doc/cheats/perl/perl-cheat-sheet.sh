# file: doc/cheat-sheets/perl/perl-cheat-sheet.sh


# how-to build perl modules as non-root https://perlmonks.org/?node=693828
The key has been to set PERL5LIB to include the path you're using 
to install to, e.g., 
$ENV{PERL5LIB} = "$ENV{HOME}/lib/perl5:$ENV{HOME}/lib" 
(I think some of the modules install differently when it's ~/lib instead of, 
say, ~/myperllib, so I found I had to add both) and 
then pass in the correct parameters to the .PL script the module comes with, e.g.: 
$^X -I$ENV{HOME}/lib Build.PL --install_base $ENV{HOME}/lib 
or 
$^X -I$ENV{HOME}/lib Makefile.PL LIB=$ENV{HOME}/lib PREFIX=$ENV{HOME}. 
The -I flag may be optional - but I like being explicit.

Once you have everything extracted and then the Makefile or Build files created, 
go ahead as normal, as if you had root. You just need to ensure PERL5LIB stays set, or that your 
scripts do a use lib ... properly before trying to use or require anything installed privately like this.




# File:PerlOneLiners.sh v.1.1.0 

# how-to install modules from the cpan
perl -MCPAN -e 'install HTML::Template' 
perl -MCPAN -e "install PAR::Packer"

perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'

#or combine it with local::lib module for non-privileged users
perl -MCPAN -Mlocal::lib=~/perl5 -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'


curl -L http://cpanmin.us | perl - --sudo App::cpanminus
cpanm Foo::Bar


# if this does not work 
##################################################
## START install perl modules by tar.gz
##################################################
# go to where you did download the modules tar
cd /path/to/module
tar -zxvf *.tar.gz

# create the make file 
perl Makefile.PL
# run make 
make
# optionally test 
make test 
# optionally create the make html 
make html 
# install 
make install
##################################################
## STOP install perl modules by tar.gz
##################################################

# how-to install modules on Windows
ppm install "HTML::Template"

# how-to install modules with cpan
# first run in your shell  ( bash , sh , cmd ) 
cpan
install Spreadsheet::XLSX
# check output - 99% of the cases no errors will be found and you are ok 


# START -- how-to search and replace recursively 
export dir=/var/aktia/3rdparty/docs/docx; 
export to_srch="emric"
export to_repl="t24"

#-- search and replace in file names
find "$dir/" -type d |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
find "$dir/" -type f |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'

#-- search and replace in file contents
find "$dir/" -type f -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
find "$dir/" -type f -name '*.bak' | xargs rm -f
# STOP  -- how-to rename files recursively


# how-to install modules from the cpan
perl -MCPAN -e 'install HTML::Template' 
perl -MCPAN -e "install PAR::Packer" 

cd sfw/perl/isg_pub ; find . -name '*.pm' -exec perl -MAutoSplit -e 'autosplit($ARGV[0], $ARGV[1], 0, 1, 1)' {} \; cd ../../../;

find . -name autosplit.ix | xargs rm -fv
find . -type d -empty -exec rm -fvr {} \;
cd sfw/perl;
find . -name '*.pm' -exec perl -MAutoSplit -e 'autosplit($ARGV[0], $ARGV[1], 0, 1, 1)' {} \;
cd ../.. ;
perl -I `pwd`/sfw/perl -I `pwd`/sfw/perl/lib -Twc sfw/perl/isg_pub/show.pl
apache2 service restart

#cat lst.lst
#HowToSplitCamelCaseTokens
#JustAnotherCamelCaseRegexOneLiner
cat lst.lst | { while read -r line ; do echo $line | perl -ne \
'my @split = $_ =~ /([A-Z]j(?:[A-Z]*(?=$|[A-Z][a-z])|[a-z]*))/g; print "@split" . "\n";' ; done ; }

# encode decode html entities 
StrToEncode='-'
echo $StrToEncode | perl -ne 'use HTML::Entities;$output=encode_entities($_);print $output' | clip

echo $StrToEncode | perl -ne 'use URI::Escape;my $encode = lc(uri_escape($_));print $encode '
  

# 1. in-place edit of *.c files changing all foo to bar
perl -p -i.bak -e 's/\bfoo\b/bar/g' *.c

# how-to rename files with regexes
find . -name '*.morphus.*' | perl -nle'$o=$_;s#^(.*)(morphus)(.*)#$1.mankeli.$3#g;$n=$_;rename($o,$n) unless -e $n ;'



find /cygdrive/c/Data/mankeli/mankeli.1.0.0.prod.elisa '*.bak' | perl -nle'$o=$_;s#^(.*)(\.bak)#$1.backup#g;$n=$_;rename($o,$n) unless -e $n ;'

find . '*.dat' | perl -nle'$o=$_;s#^(.*)(\.dat\.dat)#$1.dat#g;$n=$_;rename($o,$n) unless -e $n ;'



# 2. delete first 10 lines
perl -i.old -ne 'print unless 1 .. 10' foo.txt

# 3. change all the isolated oldvar occurrences to newvar
perl -i.old -pe 's{\boldvar\b}{newvar}g' *.[chy]

# 4. increment all numbers found in these files
perl -i.tiny -pe 's/(\d+)/ 1 + $1 /ge' file1 file2 ....

# 5. delete all but lines between START and END
perl -i.old -ne 'print unless /^START$/ .. /^END$/' foo.txt

# 6. binary edit (careful!)
perl -i.bak -pe 's/Mozilla/Slopoke/g' /usr/local/bin/netscape


# 1. command-line that reverses the whole input by lines
#    (printing each line in reverse order)
perl -e 'print reverse <>' file1 file2 file3 ....

# 2. command-line that shows each line with its characters backwards
perl -nle 'print scalar reverse $_' file1 file2 file3 ....

# 3. find palindromes in the /usr/dict/words dictionary file
perl -lne '$_ = lc $_; print if $_ eq reverse' /usr/dict/words

# 4. command-line that reverses all the bytes in a file
perl -0777e 'print scalar reverse <>' f1 f2 f3 ...

# 5. command-line that reverses each paragraph in the file but prints
#    them in order
perl -00 -e 'print reverse <>' file1 file2 file3 ....

# run contents of "my_file" as a program
perl my_file

# run debugger "stand-alone"
perl -d -e 42

# run program, but with warnings
perl -w my_file

# run program under debugger
perl -d my_file

# just check syntax, with warnings
perl -wc my_file

# useful at end of "find foo -print"
perl -nle unlink

# simplest one-liner program
perl -e 'print "hello world!\n"'

# add first and penultimate columns
perl -lane 'print $F[0] + $F[-2]'

# just lines 15 to 17
perl -ne 'print if 15 .. 17' *.pod

# in-place edit of *.c files changing all foo to bar
perl -p -i.bak -e 's/\bfoo\b/bar/g' *.c

# command-line that prints the first 50 lines (cheaply) 
perl -pe 'exit if $. > 50' f1 f2 f3 ...
find `pwd` -type f -exec perl -i.old -ne 'print unless 1 .. 5' {} \;


# delete first 10 lines
perl -i.old -ne 'print unless 1 .. 10' foo.txt

# change all the isolated oldvar occurrences to newvar
perl -i.old -pe 's{\boldvar\b}{newvar}g' *.[chy]

# command-line that reverses the whole file by lines
perl -e 'print reverse <>' file1 file2 file3 ....

# find palindromes
perl -lne 'print if $_ eq reverse' /usr/dict/words

# command-line that reverse all the bytes in a file
perl -0777e 'print scalar reverse <>' f1 f2 f3 ...

# command-line that reverses the whole file by paragraphs
perl -00 -e 'print reverse <>' file1 file2 file3 ....

# increment all numbers found in these files
perl i.tiny -pe 's/(\d+)/ 1 + $1 /ge' file1 file2 ....

# command-line that shows each line with its characters backwards
perl -nle 'print scalar reverse $_' file1 file2 file3 ....

# delete all but lines between START and END
perl -i.old -ne 'print unless /^START$/ .. /^END$/' foo.txt

# binary edit (careful!)
perl -i.bak -pe 's/Mozilla/Slopoke/g' /usr/local/bin/netscape

# look for dup words
perl -0777 -ne 'print "$.: doubled $_\n" while /\b(\w+)\b\s+\b\1\b/gi'

# command-line that prints the last 50 lines (expensively)
perl -e '@lines = <>; print @lines[ $#lines .. $#lines-50' f1 f2 f3 ...

# find /cygdrive/c/Temp/nmo/nmo.1.2.8.prod.ysg -type f | xargs perl -pi -e 's/\r\n/\n/g'
# find /cygdrive/c/Temp/nmo/nmo.1.2.8.prod.ysg -type f -name '*.bak' | xargs rm -f

# how-to sort files based on a number sequence in their file names
# list dir files , grap a number from their names , print with NumberFileName, sort , print finally the names without the Number but sorted 
ls -1 | perl -ne'm/(\d{8})/; print $1 . $_ ;' | sort -nr | perl -ne 's/(\d{8)//;print $_'

# how-to remove all blank lines 
perl -ne 'print unless /^$/'

# how-to number all lines in a file
cat tmp.txt | perl -pe '$_ = "$. $_"'

#how-to print the numbers from 1 till 20 on each line 
perl -le 'print join "\n", (1..20)'

#how-to create a file with standar row length
cat tmp.txt | perl -ne 'chomp($_); print $_ . " " . "a"x(50-length($_)) . "\n"'

# how-to convert a list of numeric ASCII values into a string
perl -le '@ascii = (7, 111, 100, 105, 110, 103); print pack("C*", @ascii)'

# how-to print the Unix time
# Print UNIX time (seconds since Jan 1, 1970, 00:00:00 UTC)
perl -le 'print time'

# how-to convert all text to uppercase
perl -nle 'print uc'
perl -ple '$_=uc'
perl -nle 'print "\U$_"'

# how-to convert all text to lowercase
perl -nle 'print lc'
perl -ple '$_=lc'
perl -nle 'print "\L$_"'

# Camel case each line
perl -ple 's/(\w+)/\u$1/g'
perl -ple 's/(?<!['])(\w+)/\u\1/g'

#'
# Strip leading whitespace (spaces, tabs) from the beginning of each line
perl -ple 's/^[ \t]+//'
perl -ple 's/^\s+//'

# Strip trailing whitespace (space, tabs) from the end of each line
perl -ple 's/[ \t]+$//'

# Strip whitespace from the beginning and end of each line
perl -ple 's/^[ \t]+|[ \t]+$//g'


#how-many *.txt files are there bellow the current dire
find -name '*.txt' | perl -ne 'print $. . " " .  $_'

# remove control chars from pwd
find `pwd` -type f -exec perl -i.bak -le 'while (<>) {chomp; s/[\000-\037]\[(\d|;)+m//+g; print ($_) };'

# print uniq file names 
find `pwd` -name '*.xml' | perl -pe 's/(.*)(\\|\/)(.*)/$3/;' | sort  | uniq -u

# how-to change the n-th token
cat change_me.txt.tmp | perl -ne 'use strict; my @tokens=split(";",$_);$tokens[1]="blah";print join (";",@tokens);'  > change_me.txt


#How to install Perl modules
gzip -dc yourmodule.tar.gz | tar -xof -
# create the make file
perl Makefile.PL
# test
make test
# install 
make install

# in Outlook - message-options-Dialog box launcher 
# how-to extract e-mails from e-mail header
cat "$file" | perl -ne 'use Email::Address;my @addresses = Email::Address->parse($_);foreach my $address (@addresses){print "\n , ".  $address->address ; }' | sort

# 
http://stackoverflow.com/questions/2165022/how-can-i-troubleshoot-my-perl-cgi-script

h2xs -AX -n ModuleName



#=============================================================
#Install a perl module from behind a firewalll using ppm
#=============================================================
Example with Compress-Bzip2 

1. Download tar package from the nearest cpan mirror to C:\Temp\TEMP folder (could be other also ; ) 
2. Create Compress-Bzip2.ppd type of file , containging the following: 

<?xml version="1.0" encoding="UTF-8"?> 
<SOFTPKG NAME="Compress-Bzip2" VERSION="2,2,09"> 
<TITLE>Compress-Bzip2</TITLE>
<ABSTRACT>Blah</ABSTRACT>
<AUTHOR>Somebody</AUTHOR>
<IMPLEMENTATION> 
<CODEBASE HREF="file:///C|/Temp/TEMP/Compress-Bzip2-2.09.tar.gz "></CODEBASE>
<INSTALL></INSTALL>
<UNINSTALL></UNINSTALL>
</IMPLEMENTATION>
</SOFTPKG> 

Attention: . Name and codebase NOT C:\ BUT file:///C|

3. Open Dos prompt into the C:\Temp\TEMP (or whichever you prevered in the beginning) 
4. Run the command : 
ppm rep add downloadedTars C:\Temp\A_DOWNLOADS\downloaded _perlmodules 
In order to add the folder to the list of your current ppm repositories 

5. ppm install Compress-Bzip2
In order to install the module from the local folder 

6. ppm rep delete myNewRepository 
In order to remove the repository from the ppm 
#Add company's servers to thte local ppm's repository 
ppm rep add linox1 http://linox.company.com/mirror/cpan/
ppm rep add linox2  ftp://linux.company.com/mirror/cpan/


#sleep for less than second in Windows 
use Win32 ; 
Win32::sleep ($time_in_milliseconds);

#=================================================================== 
#throw proper errro messages while checking the file size 
use File::stat qw(:FIELDS);
#create the obj wrapper for getting the file attributes 
my $st =stat($file) or croak ( "No $stdout : $!"); #die will shut down the program !!!! 
# get the file size 
my $size = $st->size();
$stat_obj =stat($stdout) or die "No $stdout: $!";
#throw proper errro messages ^^^^
($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
$atime,$mtime,$ctime,$blksize,$blocks) 
= stat($filename);
#===================================================================

#================================================================
# eof file: doc/cheat-sheets/perl/perl-cheat-sheet.sh