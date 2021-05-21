## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library("ensembleTax")
packageVersion("ensembleTax")

# create a fake taxonomy table of ASVs and taxonomic assignments
fake.taxtab <- data.frame(ASV = c("CGTC", "AAAA"),
                          kingdom = c("Eukaryota", "Bacteria"), 
                          supergroup = c("Stramenopile", NA),
                          division = c("Ochrophyta", NA),
                          class = c("Diatomea", NA),
                          genus = c("Pseudo-nitzschia", NA))
# create a fake taxonomic nomenclature:
map2me <- data.frame(kingdom = c("Eukaryota"), 
                     largegroup = c("Stramenopile"),
                     division = c("Clade_X"),
                     class = c("Ochrophyta"),
                     order = c("Bacillariophyta"),
                     genus = c("Pseudonitzschia"))
# look at your artificial data:
fake.taxtab
map2me

## -----------------------------------------------------------------------------
mapped.tt.stmlin <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = NULL,
                       ignore.format = FALSE,
                       synonym.file = NULL,
                       streamline = TRUE)
mapped.tt.stmlin

mapped.tt.no.stmlin <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = NULL,
                       ignore.format = FALSE,
                       synonym.file = NULL,
                       streamline = FALSE)
mapped.tt.no.stmlin

## -----------------------------------------------------------------------------
mapped.tt.exc <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = c("Bacteria"),
                       ignore.format = FALSE,
                       synonym.file = NULL,
                       streamline = TRUE)
mapped.tt.exc

## -----------------------------------------------------------------------------
# load ensembleTax's pre-compiled synonyms:
syn.df <- ensembleTax::synonyms_v2
# pull rows with Diatomea (there's only 1)
diatom.synonyms <- syn.df[which(syn.df == "Diatomea", arr.ind=TRUE)[,'row'],]
# look at it:
diatom.synonyms

## -----------------------------------------------------------------------------
mapped.tt.syn <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = c("Bacteria"),
                       ignore.format = FALSE,
                       synonym.file = "default",
                       streamline = TRUE)
mapped.tt.syn

## -----------------------------------------------------------------------------
mapped.tt.igfo <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = c("Bacteria"),
                       ignore.format = TRUE,
                       synonym.file = NULL,
                       streamline = TRUE)
mapped.tt.igfo

## -----------------------------------------------------------------------------
fake.taxtab2 <- fake.taxtab
fake.taxtab2[fake.taxtab2 == "Pseudo-nitzschia"] <- "Pseudonitzschia"
map2me2 <- map2me
map2me2[map2me2 == "Pseudonitzschia"] <- "Pseudo-nitzschia"

fake.taxtab2
map2me2

mapped.tt.igfo2 <- taxmapper(tt = fake.taxtab2,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me2,
                       exceptions = c("Bacteria"),
                       ignore.format = TRUE,
                       synonym.file = NULL,
                       streamline = TRUE)
mapped.tt.igfo2

## -----------------------------------------------------------------------------
# create a new fake taxonomy table of ASVs and taxonomic assignments
fake.taxtab <- data.frame(ASV = c("CGTC", "AAAA"),
                          kingdom = c("Eukaryota", "Bacteria"), 
                          supergroup = c("Stramenopile", "Clade_X"),
                          division = c("Ochrophyta", NA),
                          class = c("Diatomea", NA),
                          genus = c("Pseudo-nitzschia", NA))

# look at your artificial data again:
fake.taxtab
map2me

## -----------------------------------------------------------------------------
mapped.tt.ambigtest <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = NULL,
                       ignore.format = TRUE,
                       synonym.file = NULL,
                       streamline = TRUE)
mapped.tt.ambigtest

## -----------------------------------------------------------------------------
# add an entry in our tax2map2 that matches (but not exactly) one of our ASVs:
map2me <- rbind(map2me,
                c("Bacteria", "Bacteria_Clade_X", rep(NA, times = ncol(map2me)-2)))
map2me

# map again with ignore.format = FALSE.. the Bacteria will only map to Bacteria
mapped.tt.ambigtest2 <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = NULL,
                       ignore.format = FALSE,
                       synonym.file = NULL,
                       streamline = TRUE)
# confirm:
mapped.tt.ambigtest2

# now set ignore.format = TRUE.. we'll map to Bacteria Clade X:
mapped.tt.ambigtest3 <- taxmapper(tt = fake.taxtab,
                       tt.ranks = colnames(fake.taxtab)[2:ncol(fake.taxtab)],
                       tax2map2 = map2me,
                       exceptions = NULL,
                       ignore.format = TRUE,
                       synonym.file = NULL,
                       streamline = TRUE)
# confirm:
mapped.tt.ambigtest3


