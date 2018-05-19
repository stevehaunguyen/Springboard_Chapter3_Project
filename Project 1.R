library(dplyr)
library(tidyr)

#0. Load data in RStudio ------------------------------------------------

refine <- read.csv(file = "refine_original.csv")
tbl_df(refine)


#1. Clean up brand names ------------------------------------------------
refine <- arrange(refine, company)

refine$company[1:7] <- "Akzo"
refine$company[8:16] <- "philips"
refine$company[17:20] <- "Unilever"
refine$company[21:25] <- "Van Houten"

View(refine)

#2. Separate product code and number ------------------------------------

refine$Product_code <- separate(refine, "Product.code...number", c("Product_code", "Product_number"), sep = "-")[ ,2]
refine$Product_number <- separate(refine, "Product.code...number", c("Product_code", "Product_number"), sep = "-")[ ,3]

#3. Add product categories----------------------------------------------

refine$product_category <- ifelse(refine$Product_code == "p", "Smartphone",
                                                           ifelse(refine$Product_code == "v", "TV",
                                                                  ifelse(refine$Product_code == "x", "Laptop",
                                                                         ifelse(refine$Product_code == "q", "Tablet", NA))))

#4. Add full address for geocoding -----------------------------------------------------------

refine$full_address <- unite(refine, "full_address", address, city, country, sep = ",")[ ,3]

#5. Create dummy variables for company and product category -------------

refine$company_philips <- sample(0:1,nrow(refine), replace=T)
refine$company_akzo <- sample(0:1,nrow(refine), replace=T)
refine$company_van_houten <- sample(0:1,nrow(refine), replace=T)
refine$company_unilever <- sample(0:1,nrow(refine), replace=T)

refine$product_smartphone <- sample(0:1,nrow(refine), replace=T)
refine$product_tv <- sample(0:1,nrow(refine), replace=T)
refine$product_laptop <- sample(0:1,nrow(refine), replace=T)
refine$product_tablet <- sample(0:1,nrow(refine), replace=T)

View(refine)