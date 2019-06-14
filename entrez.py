from Bio import Entrez
from Bio import SeqIO

idvariable = 'WP_008193954.1'


Entrez.email = 'Edmund.Moody@bristol.ac.uk'
handle = Entrez.efetch(db="protein", id=idvariable, rettype="gb", retmode="text")
x = SeqIO.read(handle, 'genbank')
organism = x.annotations['organism']
taxonomy = x.annotations['taxonomy']
domain = taxonomy[0]

substitute = str(domain) + '_' + organism.replace(" ","_") + '_'

print (substitute)
