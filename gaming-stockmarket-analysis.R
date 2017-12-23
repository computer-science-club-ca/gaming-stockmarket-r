# Plot temporal data from stockmarket of the gaming industry between December 2007 and December 2017

# Watch for MSFT NTDOY SNE ATVI KNAMF CCOEF SQNXF UBSFF EA on http://www.nasdaq.com/symbol/ccoef/historical

library(ggplot2)
library(tidyr)
library(zoo)
library(devtools)

install_github('sinhrks/ggfortify')
# Will plot the timeSeries objectimeSeries as ggplot2 : https://cran.r-project.org/web/packages/ggfortify/ggfortify.pdf
require(ggfortify)

setwd("D:\\r\\gaming-stockmarket\\historical-quotes")

# Daily stock movements from Dec 2007 to Dec 2017 from various famous companies

# Activision/Blizzard
ATVI_stocks = read.csv("ATVI-HistoricalQuotes.csv",header=T,sep=",")
ATVI_stocks = ATVI_stocks[,c(1, 2)];
colnames(ATVI_stocks)[colnames(ATVI_stocks)=="close"] <- "Activision/Blizzard"
plot(ATVI_stocks)

# Capcom
CCOEF_stocks = read.csv("CCOEF-HistoricalQuotes.csv",header=T,sep=",")
CCOEF_stocks = CCOEF_stocks[,c(1, 2)];
colnames(CCOEF_stocks)[colnames(CCOEF_stocks)=="close"] <- "Capcom"
plot(CCOEF_stocks)

# Electronic Arts
EA_stocks = read.csv("EA-HistoricalQuotes.csv",header=T,sep=",")
EA_stocks = EA_stocks[,c(1, 2)];
colnames(EA_stocks)[colnames(EA_stocks)=="close"] <- "EA"
plot(EA_stocks)

# Konami
KNAMF_stocks = read.csv("KNAMF-HistoricalQuotes.csv",header=T,sep=",")
KNAMF_stocks = KNAMF_stocks[,c(1, 2)];
colnames(KNAMF_stocks)[colnames(KNAMF_stocks)=="close"] <- "Konami"
plot(KNAMF_stocks)

# Microsoft
MSFT_stocks = read.csv("MSFT-HistoricalQuotes.csv",header=T,sep=",")
MSFT_stocks = MSFT_stocks[,c(1, 2)];
colnames(MSFT_stocks)[colnames(MSFT_stocks)=="close"] <- "Microsoft"
plot(MSFT_stocks)

# Nintendo
NTDOY_stocks = read.csv("NTDOY-HistoricalQuotes.csv",header=T,sep=",")
NTDOY_stocks = NTDOY_stocks[,c(1, 2)];
colnames(NTDOY_stocks)[colnames(NTDOY_stocks)=="close"] <- "Nintendo"
plot(NTDOY_stocks)

# Sony
SNE_stocks = read.csv("SNE-HistoricalQuotes.csv",header=T,sep=",")
SNE_stocks = SNE_stocks[,c(1, 2)];
colnames(SNE_stocks)[colnames(SNE_stocks)=="close"] <- "Sony"
plot(SNE_stocks)

# Square Enix
SQNXF_stocks = read.csv("SQNXF-HistoricalQuotes.csv",header=T,sep=",")
SQNXF_stocks = SQNXF_stocks[,c(1, 2)];
colnames(SQNXF_stocks)[colnames(SQNXF_stocks)=="close"] <- "Square Enix"
plot(SQNXF_stocks)

# Ubisoft
UBSFF_stocks = read.csv("UBSFF-HistoricalQuotes.csv",header=T,sep=",")
UBSFF_stocks = UBSFF_stocks[,c(1, 2)];
colnames(UBSFF_stocks)[colnames(UBSFF_stocks)=="close"] <- "Ubisoft"
plot(UBSFF_stocks)

# Merge csv files data into one data frame 
combined = merge(ATVI_stocks, CCOEF_stocks)
combined = merge(combined, EA_stocks)
combined = merge(combined, KNAMF_stocks)
combined = merge(combined, MSFT_stocks)
combined = merge(combined, NTDOY_stocks)
combined = merge(combined, SNE_stocks)
combined = merge(combined, SQNXF_stocks)
combined = merge(combined, UBSFF_stocks)
tail(combined)
#take the 3dr column to the 11th, Limit of 10 time series for a plot
stocksMove = combined[,2:10]
#remove the NA
stocksMove = na.omit(stocksMove)

# Convert data to a time series : "timeSeries" object
# frequency is the number of observations per unit of time.
# for monthly, frequency = 12, For yearly data, frequency = 1
# For us the frequency is the number business days per year = 261
myTimeSeries = ts(stocksMove, start=c(2008, 1), end=c(2017, 12), frequency=245) 

#time series of stocks on one plot
autoplot(myTimeSeries, facets = FALSE) 

# Getting more specific : subset the time series (October 2007 to October 2009)
myTimeSeries2 = window(myTimeSeries, start = c(2007, 10), end = c(2009, 10))
autoplot(myTimeSeries2, facets = FALSE)

# Stock market from console builders
consoleBuilders = merge(MSFT_stocks, NTDOY_stocks)
consoleBuilders = merge(consoleBuilders, SNE_stocks)
consoleBuilders = consoleBuilders[,2:4]
consoleBuilders = na.omit(consoleBuilders)
consolesTS = ts(consoleBuilders, start = c(2008, 1), end = c(2017, 12), frequency=245) 
autoplot(consolesTS, facets = FALSE)

