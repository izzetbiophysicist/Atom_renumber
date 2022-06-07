library(bio3d)

renumber_residues <- function(pdb, first, res){
  
  
  
  pdb_atom <- pdb$atom
  pdb_trim <- trim.pdb(pdb, atom.select(pdb, resno = res))
  dmatrix <- dm(pdb_trim, grp=FALSE, mask.lower=FALSE)
  
  no <- pdb_atom$eleno
  no <- no[-which(no == first)]
  renumber <- first
  
  while(length(renumber) != (length(no)+1)){
    
    
    dist <- t(dmatrix[renumber[length(renumber)],])
    dist[,which(is.na(dist[1,]) == TRUE)] <- Inf
    dist[,which(dist == 0)] <- Inf
    dist[,renumber] <- Inf
    
    next_res <- which.min(dist)
    
    renumber <- c(renumber, next_res)
  }
  
  pdb_trim_atom <- pdb_trim$atom
  
  c<-0
  for(indx in renumber){
    c <- c+1
    pdb_trim_atom$eleno[indx] <- c
  }
  
  pdb_atom[which(pdb_atom$resno == res),] <- pdb_trim_atom 
  pdb$atom <- pdb_atom
  return(pdb)
}

args = commandArgs(trailingOnly=TRUE)

pdb <- read.pdb(args[1])
first <- as.numeric(args[2])
res <- as.numeric(args[3])

pdb <- renumber_residues(pdb, first, res)

write.pdb(pdb, "./renumbered.pdb")
