from Bio import Entrez
from Bio import SeqIO
import sys
import subprocess

filename = sys.argv[1]

taxaidlist = []
taxaspecieslist = []
taxaidtospecies = {}

with open (filename, 'r') as inputalignment:
	for line in inputalignment:
		if '>' in line:
			lengthcheck = line.split('_')[0]
			if len(lengthcheck) >= 10 and '.' not in lengthcheck:
				pass
			elif len(lengthcheck) >= 6:
				taxaid = lengthcheck
				taxaid = taxaid[1:]
				taxaidlist.append(taxaid)
			elif len(lengthcheck) <= 5:
				taxaid = lengthcheck + '_' + line.split('_')[1]
				taxaid = taxaid[1:]
				taxaidlist.append(taxaid)
for taxa in taxaidlist:
	idvariable = taxa
	Entrez.email = 'Edmund.Moody@bristol.ac.uk'
	handle = Entrez.efetch(db="protein", id=idvariable, rettype="gb", retmode="text")
	x = SeqIO.read(handle, 'genbank')
	organism = x.annotations['organism']
	substitute = str(organism.replace(" ","_") + '_')
	taxaspecieslist.append(substitute)

taxaidtospecies = dict(zip(taxaidlist, taxaspecieslist))

for key, value in taxaidtospecies.items():
	subprocess.call(['sed -i -e "s/'+key+'/'+value+'/g" '+filename+''], shell=True)
