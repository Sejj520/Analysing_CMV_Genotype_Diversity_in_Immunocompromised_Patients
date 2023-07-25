# Creating a Summary Table with Percentage of Alleles per Region:

library(tidyverse)


directory <- "/Users/ammara/R01_tab_files"  # Replace directory path with the path where files are currently being stored.
directory1 <- "/Users/ammara/FASTA_cmv_Tab_Files"

typing_files <- list.files(directory1, full.names = TRUE)

data_list <- list()

for (file in typing_files) {
  data <- read.table(file, header = TRUE, skip=1) # Can be read.table, read.delim (tab deliminated files) and read_csv
  data_list[[file]] <- data
}

combined_table1 <- bind_rows(data_list, .id = "File")

View(combined_table1)
write_csv(combined_table1, "combined_table1.csv")


no_na <- combined_table1 %>% 
  group_by(Region, Allele) %>% 
  tally() %>% 
  drop_na(Allele)

total_counts <- no_na %>% 
  group_by(Region) %>% 
  summarise(total_count = sum(n))

no_na1 <- left_join(no_na, total_counts, by = "Region") %>%
  mutate(percentage = round(n / total_count * 100, 2)) %>%
  ungroup()
no_na1

write.csv(no_na1, "Summary_percentage_table.csv")

