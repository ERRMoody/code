for i in *.hmmtbl; do ./hmmtbl2OrthoGroups_simple4Eb2.pl -t $i -d allproteomes.fa -ev 10e-6 -maxS 4; done
