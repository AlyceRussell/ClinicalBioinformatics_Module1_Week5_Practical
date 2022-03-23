---
title: "Writing Functions"
subtitle: "Module 1: Reproducible Research Example"
author: "Dr Alyce Russell <br> Postdoctoral Research Fellow <br> Centre for Precision Health, ECU <br> a.russell@ecu.edu.au <br> https://www.twitter.com/nerdrusty "
date: "Created: 3 March 2021 <br> Last Updated: 22 March 2022"
output: 
  html_document:
    css: buttons.css
    fig_caption: yes
    highlight: tango
    keep_md: yes
    theme: lumen
    toc: yes
    toc_float:
      collapsed: false
    toc_depth: 2
    self_contained: yes
---





<div style="margin-bottom:50px;">

<style>
 #TOC {
  background: url("./images/Centre-for-Precision-Health.png");
  background-size: contain;
  padding-top: 100px !important;
  background-repeat: no-repeat;
}
</style>

</div>

<style>
  p.caption {
    font-size: 1.2em;
    }
  caption {
    font-size: 1.2em;
    } 
  body{
    font-size: 12pt;
    }
</style>


<script src="hideOutput.js"></script>   


## Overview

<br>

This is a walk-through on writing functions in R. We will use publicly available data to complete this task (downloaded from [here](http://faculty.washington.edu/kenrice/bigr/index.shtml) but also available with these module 1 notes. 

<br>


```r
library(tidyverse)
library(readxl)
library(kableExtra)
library(ggpubr)
```

## Data Preparation

<br>

The data are some SNPs and basic phenotypes for 1000 individuals. 


```r
snps <- read.csv("./data/example-snp.csv", header = TRUE)
pheno <- read.csv("./data/example-pheno.csv", header = TRUE)
```

<br>

Let's explore the data a little bit. 

<br>


```r
str(snps)
```

```
## 'data.frame':	1000 obs. of  12 variables:
##  $ snp1 : chr  "CC" "TT" "CT" "CT" ...
##  $ snp2 : chr  "TT" "TT" "AT" "TT" ...
##  $ snp3 : chr  "TT" "CC" "TC" "CC" ...
##  $ snp4 : chr  "TT" "CC" "TT" "CC" ...
##  $ snp5 : chr  "CC" "CC" NA "CC" ...
##  $ snp6 : chr  "AG" "AA" "AG" "AA" ...
##  $ snp7 : chr  "TT" "AT" "AT" "AT" ...
##  $ snp8 : chr  "CC" "CT" "CC" "CC" ...
##  $ snp9 : chr  "TT" "CT" "TT" "TT" ...
##  $ snp10: chr  "CT" "CC" "CT" "CT" ...
##  $ snp11: chr  "TT" "TT" "TT" "CT" ...
##  $ id   : int  10100 10110 10177 10180 10244 10245 10271 10280 10282 10298 ...
```

```r
str(pheno)
```

```
## 'data.frame':	1000 obs. of  5 variables:
##  $ sex: chr  "MALE" "FEMALE" "FEMALE" "MALE" ...
##  $ sbp: int  132 122 173 151 148 159 149 145 158 153 ...
##  $ dbp: int  76 60 63 81 89 79 90 100 80 68 ...
##  $ bmi: int  16 17 17 18 18 19 19 19 19 19 ...
##  $ id : int  45516 21869 24512 32125 21503 30728 49088 43523 41446 28797 ...
```

<br>

## Prepare Data

<br>

Let's write a function to determine the minor allele, minor allele frequency in this population, and convert data to numeric coding (0,1,2) with 2 indicating the minor allele.  

<br>


```r
source("./rscripts/cleansnps.R")

snps_coded <- cleansnps(snps, id_var="id")
snpsbim <- cleansnps(snps, id_var="id", output="snpsbim")
```


