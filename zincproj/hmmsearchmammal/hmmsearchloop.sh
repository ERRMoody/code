for i in *.hmm; do echo $i; for d in $(more 'listofproteomes.list'); do hmmsearch -o tmp --tblout tmp.out $i $d; cat tmp.out >> ${i%%.}"".hmmtbl; done; done;

