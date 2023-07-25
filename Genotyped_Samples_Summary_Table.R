# How to Update Columns for Combined Table in R

#Step 1:
# The Wellcome Trust files provided have very long, complex file names such as:
# /Users/ammara/R01_tab_files/R01-00014-190627-B.consensus.fasta_typing.tab
# To make things easier later on, modify the file names in Finder on Mac to:
# -R0100014-190627-Blood-.consensus.fasta_typing.tab

# Step 2:
# Then, to combine and view table, follow the steps below:        
library(tidyverse)

# Set the directory where files are located
directory <- "/Users/ammara/FASTA_CMV_Tab_Files"  # Replace  directory path with the path where  files are currently being stored.

# Get a list of file names in the directory
typing_files <- list.files(directory, full.names = TRUE)

# Create an empty list to store data frames
data_list <- list()

# Read each file and store the data frames in the list
for (file in typing_files) {
  data <- read.table(file, header = TRUE, skip=1) # Can be read.table, read.delim (tab deliminated files) and read_csv
  data_list[[file]] <- data
}

# The next steps:
# Combine all data frames into one large table
combined_table <- bind_rows(data_list, .id = "File")
# Count the number of N/As you have. These can be explained as regions of low sequencing coverage in your report. 
# Get rid of alleles that say  NA

# View the combined table
View(combined_table)

# Step 3:
# Then, split columns using the script below. A data frame is created as this will then allow you to save the updated tables as their own csv file, and not part of the 'combined_table' originally used,
library(tidyverse)
Splitting_table <- combined_table %>% separate (File, c("Directory", "Patient Number", "Collection Date (yy,mm,dd)", "Sample Type"), "-", convert = FALSE)
Splitting_table

# Step 4:
# I have decided to remove the directory column, as this is not needed. To do this I use the script below and then save this as the final updated table:
Final_Split_Table <- subset(Splitting_table, select = -c(Directory)) %>% drop_na(Allele)
Final_Split_Table$Sample <- paste(Final_Split_Table$`Collection Date (yy,mm,dd)`,Final_Split_Table$`Sample Type`, sep="_")
write_csv(Final_Split_Table, "CMV_Split_Table.csv")
