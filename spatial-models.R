

---
title: "Spatial models"
author: "Frédéric Barraquand (CNRS, IMB)"
date: "2021-05-18"
output:
  html_document:
    highlight: textmate
    theme: paper
    toc: yes
    toc_depth: 4
    toc_float:
      collapsed: no
  pdf_document:
    toc: yes
    toc_depth: '4'
---


```{r setup, include = FALSE }
options(width = 300)
knitr::opts_chunk$set(cache = FALSE) 
library(rstan)
rstan_options(auto_write = FALSE)
options(mc.cores = parallel::detectCores())
library(tidyr)
library(knitr)
library(bayesplot)
```

  
Loading data and creating 

```{r load-select-data}
fulldata = read.table(file = "vole_data/PGR_Abondance_both_OK.txt",header=TRUE,sep="")
fulldata$NtSu
head(fulldata)
vole_table = fulldata %>% dplyr::select(Sect,Date,NtSu,Spr_NDVI,Win_NDVI) %>% tidyr::pivot_wider(names_from = Sect, values_from = NtSu)
vole_densities = vole_table  %>% dplyr::select(!c(Date,Spr_NDVI,Win_NDVI,U)) # we remove U as there too few data
vole_densities = as.matrix(vole_densities[1:15,])
data = list(N=vole_densities,tmax=15,I=8)
```

