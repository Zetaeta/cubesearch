library(purrr)
library(reshape2)
library(C50)

base_dir <-"data/cubes/"
files <- list.files(path=base_dir)
isText <- function(X)
{
  return(endsWith(X, ".txt"))
}
cardLists <- Filter(isText,files)
print(cardLists)
cardData <- list()#vector("list", length=length(cardLists))
i <-1
maxLength <-0
for (fileName in cardLists) {
    file = paste0(base_dir,fileName)
    cards <- scan(file=file,sep='\n',what="")
    # print(cards)
    cardData[[fileName]] <-cards
    i <- i+1
    if (length(cards) > maxLength) {
        maxLength <- length(cards)
    }
}
cardData <- map(cardData, (\(x) c(x,rep("", maxLength - length(x)))))
# print(cardData)
#print(as.data.frame(table(unlist(cardData))))
#print(sapply(cardData, table))
#print(melt(cardData))
tab <- table(melt(cardData))
#print(tab)
tab <- as.data.frame.matrix(t(tab[!(row.names(tab) %in% c("")),]))
#print(tab)
#print(tab["",])
tree <- C5.0(tab[cardLists,], factor(cardLists),control=C5.0Control(minCases=1,CF=1.0,noGlobalPruning=TRUE))
#print(str(tree))
summary(tree)
#print(table(cardData))
#print(cbind.data.frame(ID=cardLists,Result=cardData))