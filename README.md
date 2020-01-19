# 8a65fae3

# Test Package

Testing if my package works

## Installation

```R
# Tirst install the R package "devtools" if not installed
devtools::install_github('unimi-dse/8a65fae3')

# Then install the R package "shiny" if not installed
library(shiny)
```

## Usage

Load the package

```R
require(interestrates)
```

The function of the package is `hello_g()` and prints _"Hello, world! This is Greg"_
The other function is `runIR()` and runs a Shiny app

```R
hello_g()
runIR()
```