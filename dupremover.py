from Bio import SeqIO
import sys


inputf = sys.argv[1]
outputf = sys.argv[2]


with open(outputf, 'a') as outFile:
    record_ids = list()
    for record in SeqIO.parse(inputf, 'fasta'):
        if record.id not in record_ids:
            record_ids.append( record.id)
            SeqIO.write(record, outFile, 'fasta')

