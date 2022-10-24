# HackBio Biodata Science Task 2

# Import .csv file in R
microbial_stationary_phase.csv <- read.csv(file.choose())
microbial_stationary_phase.csv

# Read the table
data <- read.csv("microbial_stationary_phase.csv", row.names = 1)

# Now we need to install and load two R package which will allow us to do PCA in R
#intall
install.packages(c("factoextra", "FactoMineR"))

#load
library("factoextra")
library("FactoMineR")

# Create the Principal Component Table
pca.data <- PCA(data, scale.unit = TRUE, graph = FALSE)
#  scale.unit = TRUE is an argument to standardize the values. 

# To make sure that most of the data will be presented in the PCA plot, we need to use the fviz_eig() function. We will be using the table we created with PCA() function; pca.data
fviz_eig(pca.data, addlabels = TRUE)

# To avoid unlabeled data points (too many overlaps), we increase max.overlaps 
options(ggrepel.max.overlaps = Inf)

# To understand the correlation between the samples and how they are well represented by our model we can use fviz_pca_var() function to draw a variable correlation plot by using the command below
fviz_pca_var(pca.data, col.var = "cos2", gradient.cols = c("#FFCC00", "#CC9933", "#660033", "#330033"), repel = TRUE) 
# We can see below the Bacteria cell type are next to each other, this means they are correlated to each other. Here we do not have any negative correlation between the variables but if there was the arrow will be on the opposite sides. One last thing, since the arrow is close to the circle (long), it means the variable is well represented.

# When doing a PCA plot we have the option to plot the Bacteria cell types or the Time. It gives us the opportunity to look at the data from different angles which could enable us to find a pattern or a marker.
# Lets start by plotting the Bacteria cell types first. To do that we need to used the PCA() function again and use t() function to flip our table, so we can put the cell types as rows.
pca.data <- PCA(t(data, scale.unit = TRUE, graph = FALSE)
                
# Then we will use the viz_pca_ind() function for the visualization as shown below
fviz_pca_ind(pca.data, col.ind = "cos2", gradient.cols = c("#FFCC00", "#CC9933", "#660033", "#330033"), repel = TRUE)
                
# To add labels to the PCA plot we can use ggpubr package. First we need to install and load the package
install.packages('devtools')
library(devtools)
install_github("kassambara/ggpubr")
library(ggpubr) 
                
# then we need to assign the previous command to a
a <- fviz_pca_ind(pca.data, col.ind = "cos2", gradient.cols = c("#FFCC00", "#CC9933", "#660033", "#330033"), repel = TRUE)
                
# Now we can use ggpar() function to add labels
ggpar(a, title = "Principal Component Analysis", xlab = "PC1", ylab = "PC2", legend.title = "Cos2", legend.position = "top", ggtheme = theme_minimal())
                
# Now lets plot the Time instead of the Bacteria cell types. We will use the PCA() function
pca.data <- PCA(data, scale.unit = TRUE,ncp = 2, graph = FALSE)
                
# To color the time that enters the stationary phase in the PCA plot we will be using the first column (A1): This was the exponential phase (immediately after which the bacteria  cells entered the stationary phase). First we need to convert the column to a factor by the following command
data$A1 <- as.factor(data$A1)
                
# For the coloring palette we will use the commands below.
install.packages("RColorBrewer")
library(RColorBrewer)
                
# We will use fviz_pca_ind() function to create the PCA plot and assign it to a as we did previously.
a <- fviz_pca_ind(pca.data, col.ind = data$A1, addEllipses = TRUE)
                
# Then we will use the ggpar() function to add labels
ggpar(a, title = "Principal Component Analysis", xlab = "PC1", ylab = "PC2", legend.title = "Bacteria Stationary Phase Time", legend.position = "top", ggtheme = theme_minimal())

