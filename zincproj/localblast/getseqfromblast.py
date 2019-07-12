from Bio import SeqIO
import sys   

filename = sys.argv[1]
#this is the database file .tsv

allsequences = sys.argv[2]
#this a concatenated fasta file of all the sequences used to make the original blastdb

f = open(filename, 'r')

outfile = sys.argv[3] 
#this is output file

seqs = {}

for seq_record in SeqIO.parse(allsequences, 'fasta'):
	seqs[seq_record.id] = seq_record
i = 0
idList = {}
for line in f:
	lst = line.split()
	idList = lst
	writefile = open(outfile, 'a') #must use a to append, or will overwrite each time!
	for j in idList:
		if j in seqs:
			SeqIO.write(seqs[j], writefile, "fasta")
	i+=1
