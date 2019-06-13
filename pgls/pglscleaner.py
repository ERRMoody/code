from ete3 import Tree
import sys

t = Tree(sys.argv[1], format=1)

t.write(format=5, outfile="arcorthocleaned.tre")
