# renumber_atoms
Renumbers atoms in a molecule/residue using a distance criteria

Takes a residue with shuffled atom numbers, sets it as atom 1, finds its closest neighbor and numbers it atom 2. Switches to atom 2, finds its closest neighbor and so on

Takes a PDB, the ID of the residue to be renumbered and the nmber of the atom that will be considered as atom 1

Usage:

Rscripts renumber_residues.R pdb first_atom residue

For example, the following line renumbers the atoms in residue 1, considering atom with index 296 as atom 1

Rscript renumber_residues.R teste.pdb 296 1
