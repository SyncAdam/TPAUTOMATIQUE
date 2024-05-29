library(ggplot2)

# load data
data_df <- read.csv("sys1.csv", header = FALSE, skip = 1)
data_df1 <- read.csv("sys2.csv", header = FALSE, skip = 1)

data_matrix <- as.matrix(data_df)
data_matrix1 <- as.matrix(data_df1)

data_array <- array(data_matrix, dim = dim(data_matrix))
data_array1 <- array(data_matrix1, dim = dim(data_matrix1))

a <- 20 * log10(data_array[, 2] / abs(data_array[, 3]))
points <- cbind(data_array[, 1], a)
points2 <- cbind(data_array[, 4], a)

Threedb <- 20 * log10(1.8 / sqrt(2))

x_breaks <- seq(-180, 0, by = 20)
x_breaks <- x_breaks[x_breaks != -60]

x_breaksbode <- c(1, 3, 7.2, 10, 30)

a <- 20 * log10(data_array1[, 2] / abs(data_array1[, 3]))
points <- cbind(data_array1[, 1], a)
points2 <- cbind(data_array1[, 4], a)

p3 <- ggplot(as.data.frame(points), aes(x = points[, 1], y = points[, 2])) +
  labs(x = "fréquence (log)(Hz)", y = "20log(|A|)",
       title = "Diagramme de Bode") +
  scale_y_continuous(breaks = c(seq(-15, 5, by = 5), Threedb)) +
  scale_x_continuous(trans = "log10") +
  geom_hline(yintercept = Threedb,
             linetype = "dashed", color = "red") +
  geom_vline(xintercept = 7.2,
             linetype = "dashed", color = "blue")

ggsave("bode2.png", plot = p3, width = 6, height = 4, units = "in", dpi = 300)
