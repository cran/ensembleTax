## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library("ensembleTax")
packageVersion("ensembleTax")

# create a fake taxonomy table of ASVs and taxonomic assignments
taxtab1 <- data.frame(ASV = c("sv1", "sv2", "sv3", "sv4"),
                          kingdom = c("Eukaryota", "Eukaryota", "Eukaryota", "Eukaryota"), 
                          supergroup = c("Stramenopile", "Stramenopile", "Alveolata", "Rhizaria"),
                          division = c("Ochrophyta", NA, "Dinoflagellata", NA),
                          class = c("Bacillariophyta", NA, NA, NA),
                          genus = c("Pseudo-nitzschia", NA, NA, NA))
taxtab2 <- data.frame(ASV = c("sv1", "sv2", "sv3", "sv4"),
                          kingdom = c("Eukaryota", "Eukaryota", "Eukaryota", "Eukaryota"), 
                          supergroup = c("Stramenopile", "Alveolata", "Alveolata", "Stramenopile"),
                          division = c("Ochrophyta", "Dinoflagellata", "Dinoflagellata", NA),
                          class = c("Bacillariophyta", NA, "Syndiniales", NA),
                          genus = c("Pseudo-nitzschia", NA, NA, NA))
# look at your artificial data:
taxtab1
taxtab2

## -----------------------------------------------------------------------------
xx <- list(taxtab1, taxtab2)
names(xx) <- c("tab1","tab2")
eTax.def <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx)), 
                              tiebreakz = NULL, 
                              count.na=TRUE, 
                              assign.threshold = 0)
# show the initials and ensemble for ease-of-interpretation:
taxtab1
taxtab2
eTax.def

## -----------------------------------------------------------------------------
# create a 3rd fake taxonomy table of ASVs and taxonomic assignments
taxtab3 <- taxtab1
xx.with3 <- list(taxtab1, taxtab2, taxtab3)
names(xx.with3) <- c("tab1", "tab2", "tab3")
eTax.def <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx.with3)), 
                              tiebreakz = NULL, 
                              count.na=TRUE, 
                              assign.threshold = 0)
# show the initials and ensemble for ease-of-interpretation:
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.def

## -----------------------------------------------------------------------------
eTax.nona2 <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx)), 
                              tiebreakz = NULL, 
                              count.na=FALSE, 
                              assign.threshold = 0)
# show the initials and ensemble for ease-of-interpretation:
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.nona2

eTax.nona3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx.with3)), 
                              tiebreakz = NULL, 
                              count.na=FALSE, 
                              assign.threshold = 0)
# ensemble with 3 tables:
eTax.nona3

## -----------------------------------------------------------------------------
eTax.tb2 <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx)), 
                              tiebreakz = c("tab2"), 
                              count.na=TRUE, 
                              assign.threshold = 0)
# show the initials and ensemble for ease-of-interpretation:
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.tb2

eTax.tb3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx.with3)), 
                              tiebreakz = c("tab2"), 
                              count.na=TRUE, 
                              assign.threshold = 0)
# ensemble with 3 tables:
eTax.tb3

## -----------------------------------------------------------------------------
eTax.tb2 <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx)), 
                              tiebreakz = c("tab1"), 
                              count.na=FALSE, 
                              assign.threshold = 0)
# show the initials and ensemble for ease-of-interpretation:
taxtab1 
taxtab2
eTax.tb2

## -----------------------------------------------------------------------------
# counting NA's:
eTax.wt2 <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=c(2,1), 
                              tiebreakz = NULL, 
                              count.na=TRUE, 
                              assign.threshold = 0)
# show the initials and ensemble for ease-of-interpretation:
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.wt2

# NOT counting NA's:
eTax.wt2 <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=c(2,1), 
                              tiebreakz = NULL, 
                              count.na=FALSE, 
                              assign.threshold = 0)
# show the initials and ensemble for ease-of-interpretation:
eTax.wt2

## -----------------------------------------------------------------------------
eTax.wt3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=c(1,2,1), 
                              tiebreakz = NULL, 
                              count.na=TRUE, 
                              assign.threshold = 0)
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.wt3

## -----------------------------------------------------------------------------
eTax.wttb3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=c(1,2,1), 
                              tiebreakz = c("tab1"), 
                              count.na=TRUE, 
                              assign.threshold = 0)
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.wttb3

## -----------------------------------------------------------------------------
eTax.wttb3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=c(1,2,1), 
                              tiebreakz = c("tab2"), 
                              count.na=TRUE, 
                              assign.threshold = 0)
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.wttb3

## -----------------------------------------------------------------------------
# tie-breaking to prioritize table 1, but with assign.threshold = 60%
eTax.at <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx)), 
                              tiebreakz = c("tab1"), 
                              count.na=TRUE, 
                              assign.threshold = 0.6)
# show the initials and ensemble for ease-of-interpretation:
taxtab1 # (remember taxtab3 is identical to this, so count 2x)
taxtab2
eTax.at

# take away the tiebreaker and weight table 1 2x:
eTax.at <- assign.ensembleTax(xx, 
                              tablenames = names(xx), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=c(2,1), 
                              tiebreakz = NULL, 
                              count.na=TRUE, 
                              assign.threshold = 0.6)
eTax.at

## -----------------------------------------------------------------------------
# a low threshold:
eTax.at3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx.with3)), 
                              tiebreakz = NULL, 
                              count.na=TRUE, 
                              assign.threshold = 0.5)
eTax.at3

# a high threshold (need all 3 to agree here for ensemble assignment):
eTax.at3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx.with3)), 
                              tiebreakz = NULL, 
                              count.na=TRUE, 
                              assign.threshold = 0.9)
eTax.at3

## -----------------------------------------------------------------------------
# a low threshold with count.na = FALSE:
eTax.at3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx.with3)), 
                              tiebreakz = NULL, 
                              count.na=FALSE, 
                              assign.threshold = 0.5)
eTax.at3

# a high threshold with count.na = FALSE (need all 3 to agree here for ensemble assignment):
eTax.at3 <- assign.ensembleTax(xx.with3, 
                              tablenames = names(xx.with3), 
                              ranknames = colnames(taxtab1)[2:ncol(taxtab1)],
                              weights=rep(1,length(xx.with3)), 
                              tiebreakz = NULL, 
                              count.na=FALSE, 
                              assign.threshold = 0.9)
eTax.at3

