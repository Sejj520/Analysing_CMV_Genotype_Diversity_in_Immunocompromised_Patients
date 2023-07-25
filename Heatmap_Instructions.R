# Heatmap Script:

library(tidyverse)
library(ggplot2)
library(RColorBrewer)


read.csv("CMV_Split_Table.csv")
SampleWithDate <- read.csv("CMV_Split_Table.csv")


# To create a heatmap for all 74 regions:

color_palette <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF")
allele_labels <- c(1, 2, 3, 4, 5, 6, 7, 8)

SampleWithDate %>%
  filter(factor(`Patient.Number`) == "H0200049") %>%
  ggplot(aes(x = factor(Sample), y = factor(Region), fill = factor(Allele))) +
  geom_tile(color = "black", size = 1) +
  scale_fill_manual(values = setNames(color_palette, allele_labels), drop = FALSE) +
  theme_classic() +
  labs(title = "Patient H0200049",
       x = "Collection Date (yy,mm,dd)", y = "Region", fill = "Genotype") +
  theme(plot.title = element_text(hjust = 0.5))


# To create a heatmap that displays specific regions of the genome:

Regions_of_interest <- c(26,27,28,36,37,38,39,40)
color_palette <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF")
allele_labels <- c(1, 2, 3, 4, 5, 6, 7, 8)

SampleWithDate$Allele <- factor(SampleWithDate$Allele, levels = allele_labels)

SampleWithDate %>%
  filter(factor(`Patient.Number`) == "H0200049", Region %in% Regions_of_interest) %>%
  ggplot(aes(x = factor(Sample), y = factor(Region), fill = factor(Allele))) +
  geom_tile(color = "black", size = 1) +
  scale_fill_manual(values = setNames(color_palette, allele_labels), drop = FALSE) +
  theme_classic() +
  labs(title = "Patient H0200049",
       x = "Collection Date (yy,mm,dd)", y = "Region", fill = "Genotype") +
  theme(plot.title = element_text(hjust = 0.5))



# Heatmaps for reference strains
Ref_regions <- c(26,27,28,36,37,38,39,40)
Ref_split_table %>%
  filter(factor(sample) == "Europe_United Kingdom_NC_006273.2_Human_herpesvirus_5_strain_Merlin_complete_genome", region %in% Ref_regions) %>%
  ggplot(aes(x = factor(sample), y = factor(region), fill = factor(genotype))) +
  geom_tile(colour = "black", size = 1) +
  scale_fill_manual(values = c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF"),
                    labels = levels(factor(Ref_split_table$genotype))) +
  theme_classic() +
  labs(title = "Merlin Strain - Geographic Regions of Interest",
       x = "Index Number", y = "Region", fill = "Genotype") +
  theme(plot.title = element_text(hjust = 0.5))



# Strain Titles:
# "Europe_United Kingdom_NC_006273.2_Human_herpesvirus_5_strain_Merlin_complete_genome"
# "Americas_USA_FJ616285.1_Human_herpesvirus_5_strain_Towne_complete_genome"