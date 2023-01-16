
# rplayground

<!-- badges: start -->
<!-- badges: end -->

## 2023/01/12 | Play with datasets
### Flow of data check
1. `summary(df)` and `skim(df)` to check the over all stats
1. `glimpse(df)` to check the variables
1. `plot(df, type = [c("l", "b")]), col = column.name`(when many variables) or `ggpairs(df, aes(colour=column.name, alpha=0.5))`(in standard) to visualize the data
1. `res <- lm(y ~ x.1 + x2 + ... + x.n))` and `plot(res)`