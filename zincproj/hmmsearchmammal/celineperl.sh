for i in *.hmmtbl; do ./hmmtbl2OrthoGroups_simple4Eb2.pl -t $i -d allmammals.fa -ev 10e-4 -maxS 4; done
