from Bio import Entrez
from Bio import SeqIO
from subprocess import call
#import modules

file = sys.argv[1]

open file
    for line in file:
        if '>' in line:
            toswap = > until _
            sed 's/>/substitute/g'


idvariable = 'WP_008193954.1'
#create id variable

Entrez.email = 'Edmund.Moody@bristol.ac.uk'
handle = Entrez.efetch(db="protein", id=idvariable, rettype="gb", retmode="text")
x = SeqIO.read(handle, 'genbank')
organism = x.annotations['organism']
taxonomy = x.annotations['taxonomy']
domain = taxonomy[0]
substitute = str(domain) + '_' + organism.replace(" ","_") + '_'
#entrez system, create a variable with domain and taxa info

print (substitute)
#print taxainfo
