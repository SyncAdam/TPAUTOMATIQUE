library(ggplot2)

# load data
data_df <- read.csv("sys1.csv", header = FALSE, skip = 1)

data_matrix <- as.matrix(data_df)

data_array <- array(data_matrix, dim = dim(data_matrix))

a <- 20 * log10(data_array[, 2] / abs(data_array[, 3]))
points <- cbind(data_array[, 1], a)
points2 <- cbind(data_array[, 4], a)

Threedb <- 20 * log10(1.8 / sqrt(2))

x_breaks <- seq(-180, 0, by = 20)
x_breaks <- x_breaks[x_breaks != -60]

x_breaksbode <- c(1, 3, 7.2, 10, 30)

p <- ggplot(as.data.frame(points), aes(x = points[, 1], y = points[, 2])) +
  geom_point() +
  geom_line() +
  labs(x = "fréquence (log)(Hz)", y = "20log(|A|)",
       title = "Diagramme de Bode") +
  scale_y_continuous(breaks = c(seq(-15, 5, by = 5), Threedb)) +
  scale_x_continuous(trans = "log10", breaks = x_breaksbode) +
  geom_hline(yintercept = Threedb,
             linetype = "dashed", color = "red") +
  geom_vline(xintercept = 7.2,
             linetype = "dashed", color = "blue")

p2 <- ggplot(as.data.frame(points2), aes(x = points2[, 1], y = points2[, 2])) +
  geom_point() +
  geom_line() +
  labs(x = "déphasage (degrée)", y = "20log(|A|)",
       title = "Diagramme de Black") +
  geom_hline(yintercept = 0,
             linetype = "dashed", color = "red") +
  geom_vline(xintercept = -57,
             linetype = "dashed", color = "blue") +
  scale_x_continuous(limits = c(-180, 0),
                     breaks = c(x_breaks, -57))


# Print plot

ggsave("bode1.png", plot = p, width = 6, height = 4, units = "in", dpi = 300)
ggsave("black1.png", plot = p2, width = 6, height = 4, units = "in", dpi = 300)