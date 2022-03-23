# Function to convert SNP genotypes

cleansnps <- function(snp_df, 
                      id_var,
                      output = "snps" #option "snpsbim"
                      ){
  
  #tell the function what packages need to be loaded for it to work
  require(tidyverse)
  
  #rearrange columns
  snp_df1 <- snp_df[,-grep(id_var, colnames(snp_df))]
  snp_df1 <- cbind(snp_df[,id_var], snp_df1)
  names(snp_df1)[1] <- id_var
  
  #delete obs with missing snps
  snp_df1 <- snp_df1[complete.cases(snp_df1),]
  
  #count occurrence of each allele by snp  
  tmp <- data.frame()
  for(i in 2:ncol(snp_df1)){
  
    snpn <- snp_df1 %>%
      group_by(snp_df1[,i]) %>%
      count() 
    
    snpn$snp <- colnames(snp_df1)[i]
    names(snpn)[1] <- "allele" 
    
    rownames(snpn) <- NULL 
    
    tmp <- rbind(tmp, snpn)
  }
  
  #calculate proportion of each allele, minor allele frequency, code smallest to largest p as 2 to 0
  tmp1 <- tmp %>%
    group_by(snp) %>%
    mutate(p = n/sum(n)) %>%
    arrange(snp,-p) %>%
    mutate(geno = seq(1,3,1)) %>%
    mutate(maf = min(p)) %>%
    mutate(minorA = allele[which(p == maf)])
  
  #create clean data frame with snp, allele, maf
  tmp2 <- tmp1 %>%
    group_by(snp, minorA) %>%
    summarise(maf = mean(maf))

  #recode snps according to given order
  tmp3 <- snp_df1  
  for(i in 1:nrow(tmp3)){
    for(j in 2:ncol(tmp3)){
      tmp3[i,j] <- ifelse(tmp3[i,j]==tmp1$allele[tmp1$geno==1 & tmp1$snp==colnames(tmp3)[j]], 0,
                          ifelse(tmp3[i,j]==tmp1$allele[tmp1$geno==2 & tmp1$snp==colnames(tmp3)[j]], 1, 2))
    } 
  }
  
  #output snps if default or snpsbim (i.e. snp info) if output="snpsbim"
  if(output == "snpsbim"){
    return(tmp2)
  } else {
    return(tmp3)
  }
  
}