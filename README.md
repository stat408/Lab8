# Lab8

Please turn in **both an HTML/PDF/DOC file and your R Markdown script**. 

## Lab Overview

For this lab we will focus on writing functions and applying those functions to a data frame containing trip information from Uber. This data was compiled by 538.com and used in several stories including [https://fivethirtyeight.com/features/uber-is-serving-new-yorks-outer-boroughs-more-than-taxis-are/](https://fivethirtyeight.com/features/uber-is-serving-new-yorks-outer-boroughs-more-than-taxis-are/). More information about the data can be found at [https://github.com/fivethirtyeight/uber-tlc-foil-response](https://github.com/fivethirtyeight/uber-tlc-foil-response), but the data has been cleaned for you.

The entire lab will be worth 10 points. Clarity of code, including comments and interpretable variables names, along with thoughtful writing with an emphasis on concise interpretations will be considered when grading. 

## Questions
Answer the following questions in this R Markdown document. Please include code where necessary.


Download the Uber dataset, available at: [http://math.montana.edu/ahoegh/teaching/stat408/datasets/UberMay2014.csv](http://math.montana.edu/ahoegh/teaching/stat408/datasets/UberMay2014.csv). This file contains the trip start time for Uber pickups in New York City during the first week of May, 2014. 

```{r}
library(readr)
uber <- read.csv('http://math.montana.edu/ahoegh/teaching/stat408/datasets/UberMay2014.csv', stringsAsFactors = F)
```

### 1. Writing functions
#### a. (5 points)
Suppose would like to identify whether there are more Uber pickups on a weekday or weekend day, an average. Write a function that takes 
- a character string with the `uber$Date.Time` format and 
- returns a character string stating whether the day is a `weekday` or `weekend`.

```
FindDay <- function(day){
  # finds ... 
  # ARGS:
  # Returns:
 
}
```


Verify this works by running the the following code.

```
FindDay("5/1/2014 0:02:00")
FindDay(uber$Date.Time[1])
FindDay(uber$Date.Time[142812])
```

#### b. (5 points)
We are also interested in knowing which block of time has the most trips. Note that these times are in military time, where 0 = midnight and 20 = 8 PM. Write a function called `FindTime()` that:

- takes an input time as hh:mm:ss ("12:21:00") in military time and 
-returns the following blocks of time:

    - "late night": after 22 - to 4
    - "morning": after 4 - to 10
    - "midday": after 10 - to 16
    - "evening": after 16 -  to 22

Now complete the function below and include documentation

```
FindTime <- function(time.in){
  # Function to 
  # ARGS: time as string with 'hh:mm'
  # Returns: 
  
}
```
Demonstrate this works by showing `FindTime('04:37:17')` and `FindTime('23:12:01')`

