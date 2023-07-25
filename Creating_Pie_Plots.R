# How to Create Pie Plots from Combined Table Data in R

# Step 1 - Create a tally of the combined table data
# For tally, we will also create a data frame called no_na. This is so that we can create a tally without N/As appearing under the Allele column. This happens due to poor sequencing depth. At the end of the data frame, we add drop_na(Allele):
no_na <- combined_table %>%  group_by(Region, Allele) %>% tally() %>% drop_na(Allele)
no_na
# This will give you the total of each Allele at each region. This tally data can then be used to create the pie charts.

# Step 2 - Calculate the percentages for the 74 pie charts
# This step involves performing the percentage calculations as a separate column in the data frame:
total_counts <- no_na %>% group_by(Region) %>% summarise(total_count = sum(n))

no_na <- left_join(no_na, total_counts, by = "Region") %>%
  mutate(percentage = n / total_count * 100) %>%
  ungroup()

# Step 4 - Creating the Pie Charts
ggplot(no_na, aes(x = "", y = percentage, fill = factor(Allele))) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  theme_void() +
  facet_wrap(~Region, strip.position = "bottom") +
  theme(strip.text = element_text(size = 10, face = "bold"),
        strip.background = element_blank(),
        panel.spacing = unit(0.5, "lines"),
        legend.position = "top") +
  geom_text(aes(label = sprintf("%.2f%%", percentage)),
            position = position_stack(vjust = 2),
            color = "black", size = 0.5) +
  scale_fill_brewer(palette = "Set1")