import re
import sys

def get_file_data(filename):
	f = open(filename, "r")
	lines = []
	for line in f:
		lines.append(line.rstrip("\n"))

		f.close
	return(lines)

def read_fasta(filename):
	import re
	lines = get_file_data(filename)
	seqs = {}
	key = ""
	value = ""

	for line in lines:
		line = line.rstrip("\n")
		if re.search(">", line):
			if key:
				seqs[key] = value
				key = line[1:]
			else:
				key = line[1:]
			value = ""
		else:
			value = value + line
	seqs[key] = value
	return(seqs)

filename = sys.argv[1]

output = read_fasta(filename)

print (output)
