#!/usr/bin/perl
# Nom du programme: hmmtbl2OrthoGroups_simple4Eb.pl
# Version 1.0 (March 2019)
# But: Read 
# Auteur: CP
# Arguments: 
#    
#            
########################################################################


$USAGE = "\n HFx2OrthoGroups.pl CP version 1.0 (November 2018)\n\n [USAGE]  : hmmtbl2OrthoGroups_simple4Eb.pl -t file.hmmtbl -d database.fasta -ev maxev -maxS maxnbofseqpergenome\n\n" ;
# Affiche les informations si aucun argument n'est entré
unless( @ARGV )
{
    print $USAGE ;
    exit ;
}

$list = 0;
$file = 0;
$evmax = 0.00001;
$maxseq = 1;

#Initialisation des variables
for $i (0..10){
	if ($ARGV[$i] eq "-t"){ $hmmtbl = $ARGV[$i+1]; $file = 1;}
	if ($ARGV[$i] eq "-l"){ $listfiles = $ARGV[$i+1]; $list = 1;}
	if ($ARGV[$i] eq "-d"){ $database = $ARGV[$i+1]; }
	if ($ARGV[$i] eq "-ev"){ $evmax = $ARGV[$i+1];}
	if ($ARGV[$i] eq "-maxS"){ $maxseq = $ARGV[$i+1];}
}

%Hdatabase = ();


open(database,"<$database")|| die ("Error opening file: ".$database) ;
while(<database>){
	$line = $_;
	chomp($line);	$line =~ s/\r//g;
	if ($line =~ />/){
		$line =~ s/\>//g;
		$id = $line;
		#@split_line = split(/\_/, $line);
		#$id = $split_line[0];
		$Hid_sps{$id} = $line;
		#print "id in db =".$id."\n";
	}
	else{
		if(exists $Hdatabase{$id} ){
			$Hdatabase{$id} = $Hdatabase{$id}.$line;
		}
		else{
			$Hdatabase{$id} = $line;
		}
	}
}
#print "database creation over\n";

#system "rm -rf HmmOG_fasta";
system "mkdir HmmOG_fasta";
#print "previous files deleted\n";



if ($list == 1){
	open(listfiles,"<$listfiles")|| die ("Error opening file: ".$listfiles) ;
	while(<listfiles>){
		$line = $_;
		chomp($line);	$line =~ s/\r//g;
		$hmmtbl = $line;
		CreateOG();
	}
	WriteTableOG(%HAverage);
	#AJouter le nomber de seq par OG.
	

}
if ($file == 1){
	CreateOG();
	WriteTableOG(%HAverage);
}



print "\n";




## FUNCTIONS ##



# Writing the fasta file for the OG2 print ==> OG precedent en realité.
sub WritingFastaOG{
	my %hash = @_;
	$out = "HmmOG_fasta/".$OG2print.".faa";	
	open(OUT, ">$out")|| die ("error writing");
	foreach my $seq  (keys %hash){  
		print OUT ">".$seq."\n".$hash{$seq}."\n";	
	}
	close(OUT);
}

sub AverageHash{ 
	my %hash = @_;
	my $divider = 0;
	$Sum = 0;
	$average = 0;
	for my $elem (values %hash){
		#print "elem average = ".$elem."\n";
		$Sum = $Sum + $elem;
		$divider++;
	}
	#print "sum = ".$Sum."\n";
	#print "divider = ".$divider."\n";
	if ($divider == 0){}
	else{
		$average = $Sum/$divider;
		return $average;
	}
}

sub MedianHash{
	my @Array = @_; my $i = 0;
	#for my $elem (values %Array){
	#	$Array[$i] = $elem; $i ++;
	#}
	my @vals = sort {$a <=> $b} @Array;
	my $len = @vals;
	if($len%2){ #odd?
		return $vals[int($len/2)];
	}
	else{ # even
		return ($vals[int($len/2)-1] + $vals[int($len/2)])/2;
	}
}

sub CreateOG{
	%HSeqSps = ();
	%Hfasta = ();

	#@split_hmmtbl = split(/\_/, $hmmtbl);
	#$OG2print = $split_hmmtbl[0];
	$OG2print = $hmmtbl;
	#print "OG2 print: ".$OG2print."\n";
	$nbsps = 0;
	$nbseq = 0;

	open(tbl,"<$hmmtbl")|| die ("Error opening file: ".$hmmtbl) ;
	while(<tbl>){
		$line = $_;
		chomp($line);	$line =~ s/\r//g; $line =~ s/\s+/\t/g;
		if ($line =~ /#/){
		}
		else{
			@split_line = split(/\t/, $line); 
			$seq = $split_line[0];
			@split_seq = split(/\_/, $seq);
			#$seqid = $split_seq[0];
			$seqid = $seq;
			$sps = $split_seq[0];
			#print "seqid: ".$seqid."\n";
			#print "sps: ".$sps."\n";			
			
			$evalue = $split_line[4];
			if ($evalue <= $evmax){
				if ($HSeqSps{$sps}  > $maxseq-1){}
				else{
					if (exists $HSeqSps{$sps}){
						$HSeqSps{$sps} = $HSeqSps{$sps} + 1; 

					}
					else {
						$HSeqSps{$sps} = 1; $nbsps ++;
					}
				
					$Hfasta{$seqid} = $Hdatabase{$seqid};
					$nbseq ++;
				}
			}
		}
	}
	$HnbSeq{$OG2print} = $nbseq;
	$HnbSps{$OG2print} = $nbsps;
	$AverageSeqperSps = AverageHash(%HSeqSps);
	$HAverage{$OG2print} = $AverageSeqperSps;
	WritingFastaOG(%Hfasta);
	
	print $OG2print." done\n";
}


sub WriteStatGeneral{
	$statG = "StatGeneral.stat";
	open(OUT, ">$statG")|| die ("error writing");
	print OUT "Total number of OG\t".$nbtotalOG."\n";
	print OUT "Number of OG with ".$minseq." or more sequences\t".$nbfilesupto."\n";
	print OUT "Number of OG with between ".$minseq." and ".$maxseq." sequences\t".$nbfilesbetweento."\n";
	print OUT "Number of OG with 4 or more sequences\t".$nbfilesupto4."\n";
	print OUT "Number of OG with ".$minsps." or more sps\t".$Spsnbfilesupto."\n";
	print OUT "Average Nb Seq\t".$AverageSeq."\n";
	#print OUT "Median Nb Seq\t".$MedianSeq."\n";
	print OUT "Average Nb Sps\t".$AverageSps."\n";
	#print OUT "Median Nb Sps\t".$MedianSps."\n";
	close(OUT);
}

sub WriteTableOG{
	my %hash = @_;
	$statOG = "StatperOG.stat"; # to modify
	open(OUT, ">$statOG")|| die ("error writing");
	foreach $og  (sort {$a <=> $b} keys %hash){  
		print OUT $og."\t".$HnbSeq{$og}."\t".$HnbSps{$og}."\t".$hash{$og}."\n";	
	}
	close(OUT);
}

