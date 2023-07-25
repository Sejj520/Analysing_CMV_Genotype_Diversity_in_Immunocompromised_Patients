# To show Differences in genotype diversity between blood, blood and urine, 

## To identify genotype variation in the blood

# Step 1- load the table for blood samples only:

library(tidyverse)
library(dplyr)
# Read the CSV file into a data frame
df_sampleTypeBlood <- read.csv("GenotypeTotals_Blood.csv")
df_sampleTypeBlood

# Step 2- Group by Patient.ID and Region
df_changesBlood <- df_sampleTypeBlood %>%
  arrange(Patient.ID, Region, `Collection.Date..yy.mm.dd.`) %>%
  group_by(Patient.ID, Region) %>%
  mutate(Allele_change = ifelse(Allele != lag(Allele, default = first(Allele)), 1, 0)) %>%
  ungroup()
df_changesBlood

# Step 3- Summarize the data to get the total sum of 0s and 1s for each Region

df_summaryBlood <- df_changesBlood %>%
  group_by(Patient.ID, Region) %>%
  summarise(Total_0s = sum(Allele_change == 0),
            Total_1s = sum(Allele_change == 1))
print(df_summaryBlood)
write_csv(df_summaryBlood, "df_SummaryBlood.csv")

# Step 4 -Print the summary of total 1s only, as we only need this to calculate genotype change

df_summaryofChangesBlood <- df_changesBlood %>%
  group_by(Patient.ID, Region) %>%
  summarise(Total_1s = sum(Allele_change == 1))
print(df_summaryofChangesBlood)

# Step 5 - # To then summarise all of the 'Total 1s' for EACH PATIENT

df_summary_patientBlood <- df_summaryofChangesBlood %>%
  group_by(Patient.ID) %>%
  summarise("Total Number of Genotype Changes per Patient" = sum(Total_1s))
print(df_summary_patientBlood)

write_csv(df_summary_patientBlood, "df_summary_patientBlood.csv")