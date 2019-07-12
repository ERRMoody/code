for i in *.hmmtbl; do ./hmmtbl2OrthoGroups_simple4Eb2.pl -t $i -d allproteomes.fa -ev 10e-7 -maxS 1; done
