#
# ************* UNDER CONSTRUCTION *************
#
# ====================================================================
#
# Decision tree: rpart
# WORKING, adapted from: www.rdatamining.com/docs/regression-and-classification-with-r
# Good ref: http://www.milbo.org/doc/prp.pdf

# Load up packages
library(rpart)
library(rpart.plot)
library(TH.data)

# Choose data
dataset <- all_numbers

# Random seed
set.seed(1234)

# Subset for train / test datasets
ind <- sample(2, nrow(dataset), replace=TRUE, prob=c(0.7, 0.3))  # must add to 1
data.train <- dataset[ind==1,]
data.test <- dataset[ind==2,]

# Train Decision Tree
myFormula <- Weight ~ Age + NumCases + NumParticipants + ZipDens + ZipCount + CaseDuration

# R part function
data_rpart <- rpart(myFormula, data = data.train,
                    control = rpart.control(minsplit = 10))

print(data_rpart)
rpart.plot(data_rpart)

# Select best
opt <- which.min(data_rpart$cptable[, "xerror"])
cp <- data_rpart$cptable[opt, "CP"]

# prune tree
data_prune <- prune(data_rpart, cp = cp)

# plot tree
rpart.plot(data_prune)
text(data_prune, use.n = T)

# ==============================================================
# Highlight only the above and RUN to get simple blue/white tree
# Begin formatting: colors, etc for nicer visualization

prp(data_prune,
    type = 4,                # left and right split labels (see Figure 2)
    clip.right.labs = FALSE, # full right split labels
    extra = 101,             # show nbr of obs and percentages (see Figure 3)
    under = TRUE,            # position extra info _under_ the boxes
    under.cex = 1.2,         # size of text under the boxes (default is .8)
    fallen.leaves = TRUE,    # put leaves at the bottom of plot
    box.palette = "GnYlRd",  # color of the boxes
    branch = 0.8,             # branch lines with narrow shoulders and down slopes
    round = 10,               # no rounding of node corners i.e. use rectangles
    leaf.round = 9,          # round leaf nodes (for leaves, this supersedes the round arg)
    prefix = "Avg \n",       # prepend this string to the node labels
    cex = 0.8,
    
    main = "Decision Tree:  ~ ",     
    # main title
    
    cex.main = 1.0,          # use big text for main title
    branch.col = "gray",     # color of branch lines
    branch.lwd = 5)          # line width of branch lines


# Evaluate model itself
data_pred <- predict(data_prune, newdata = data.test)

# Plotting
xlim <- range(dataset$Weight)
plot(data_pred ~ Weight, data = data.test, xlab = "Observed",
     ylab = "Prediction", ylim = xlim, xlim = xlim)

# Perfect line for comparison
abline(a = 0, b = 1)

# =====================================================================

# Clean up R Studio
remove(ind,dataset, data.train, data.test,myFormula,data_rpart,opt,cp,data_prune,data_pred,xlim)