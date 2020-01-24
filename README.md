
<!-- README.md is generated from README.Rmd. Please edit that file -->

# knitscm

<!-- badges: start -->

<!-- badges: end -->

A [knitr](https://github.com/yihui/knitr) engine for Scheme

## Installation

You can install the development version of knitscm from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("igjit/knitscm")
```

## Example

```` markdown
```{r setup, include=FALSE}
library(knitscm)
handle <- run_gauche()
knitr::opts_chunk$set(handle = handle)
```

```{scm results=FALSE}
(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))
```

```{scm}
(fact 5)
```
````
