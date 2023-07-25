# Creating Boxplots to show the numebr of genotype changes in each sample type.

library(ggplot2)
library(dplyr)

# Assuming you have df_summary_patientBU, df_summary_patientBS, and df_summary_patientBlood data frames

# Combine the three data frames using bind_rows
df_combined <- bind_rows(
  df_summary_patientBU %>% mutate(dataset = "Blood and Urine Samples"),
  df_summary_patientBS %>% mutate(dataset = "Blood and Saliva Samples"),
  df_summary_patientBlood %>% mutate(dataset = "Blood Samples")
)

# Create the combined box plot
ggplot(df_combined, aes(x = dataset, y = `Total Number of Genotype Changes per Patient`, fill = dataset)) +
  geom_boxplot(coef = 1.5) +
  labs(x = "Patient Sample Types", y = "Total Genotype Change") +
  ggtitle("Measuring Genotype Variation for Different Patient Sample Types") +
  theme_classic() +
  theme(plot.background = element_rect(fill = "white"),
        panel.grid.major = element_line(color = "gray", linetype = "dashed"),
        panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = seq(0, max(df_combined$`Total Number of Genotype Changes per Patient`), 10))