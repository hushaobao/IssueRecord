
# 设置文件目录
# setwd("./data")
# 设置保留小数点后三位
# options(digits = =3)

# library(RNHANCES)
library(foreign)
library(dplyr)
library(survey)
library(reshape2)
library(do)
library(openxlsx)


# 加载数据

# DEMO

# load data from file
select_colnames <- c(
  "SEQN", "SDMVPSU", "SDMVSTRA", "RIDAGEYR", "RIAGENDR",
  "RIDEXPRG", "RIDRETH1", "DMDEDUC2", "INDHHIN2", "WTMEC2YR"
)
d_DEMO_F <- read.xport("data/DEMO_F.xpt")[, select_colnames]
d_DEMO_G <- read.xport("data/DEMO_G.xpt")[, select_colnames]
d_DEMO_H <- read.xport("data/DEMO_H.xpt")[, select_colnames]
d_DEMO_I <- read.xport("data/DEMO_I.xpt")[, select_colnames]
d_DEMO_J <- read.xport("data/DEMO_J.xpt")[, select_colnames]

# add column Year
d_DEMO_F$Year <- "2009-2010"
d_DEMO_G$Year <- "2011-2012"
d_DEMO_H$Year <- "2013-2014"
d_DEMO_I$Year <- "2015-2016"
d_DEMO_J$Year <- "2017-2018"

# merge data
d_DEMO <- dplyr::bind_rows(d_DEMO_F, d_DEMO_G, d_DEMO_H, d_DEMO_I, d_DEMO_J)

# rename col name
d_DEMO <- plyr::rename(
  d_DEMO,
  c(
    SDMVPSU = "sdmvpsu", SDMVSTRA = "sdmvstra",
    RIDAGEYR = "age", RIAGENDR = "sex",
    RIDEXPRG = "preg", RIDRETH1 = "eth",
    DMDEDUC2 = "edu", INDHHIN2 = "income",
    WTMEC2YR = "wtmec2yr"
  )
)

# DIQ 糖尿病

select_colnames <- c("SEQN", "DIQ010")
d_DIQ_F <- read.xport("data/DIQ_F.xpt")[, select_colnames]
d_DIQ_G <- read.xport("data/DIQ_G.xpt")[, select_colnames]
d_DIQ_H <- read.xport("data/DIQ_H.xpt")[, select_colnames]
d_DIQ_I <- read.xport("data/DIQ_I.xpt")[, select_colnames]
d_DIQ_J <- read.xport("data/DIQ_J.xpt")[, select_colnames]

# add column Year
d_DIQ_F$Year <- "2009-2010"
d_DIQ_G$Year <- "2011-2012"
d_DIQ_H$Year <- "2013-2014"
d_DIQ_I$Year <- "2015-2016"
d_DIQ_J$Year <- "2017-2018"

# merge data
d_DIQ <- dplyr::bind_rows(d_DIQ_F, d_DIQ_G, d_DIQ_H, d_DIQ_I, d_DIQ_J)
# rename col name
d_DIQ <- plyr::rename(d_DIQ, c(DIQ010 = "diabetes"))


# GLU 空腹血糖
select_colnames <- c("SEQN", "LBXGLU")
d_GLU_F <- read.xport("data/GLU_F.xpt")[, select_colnames]
d_GLU_G <- read.xport("data/GLU_G.xpt")[, select_colnames]
d_GLU_H <- read.xport("data/GLU_H.xpt")[, select_colnames]
d_GLU_I <- read.xport("data/GLU_I.xpt")[, select_colnames]
d_GLU_J <- read.xport("data/GLU_J.xpt")[, select_colnames]

# add column Year
d_GLU_F$Year <- "2009-2010"
d_GLU_G$Year <- "2011-2012"
d_GLU_H$Year <- "2013-2014"
d_GLU_I$Year <- "2015-2016"
d_GLU_J$Year <- "2017-2018"

# merge data
d_GLU <- dplyr::bind_rows(d_GLU_F, d_GLU_G, d_GLU_H, d_GLU_I, d_GLU_J)
# rename col name
d_GLU <- plyr::rename(d_GLU, c(LBXGLU = "glu"))


# ALQ  饮酒
select_colnames <- c("SEQN", "ALQ130", "ALQ140Q", "ALQ140U")
select_colnames_1 <- c("SEQN", "ALQ130", "ALQ141Q", "ALQ141U")
select_colnames_2 <- c("SEQN", "ALQ130", "ALQ142")

d_ALQ_F <- read.xport("data/ALQ_F.xpt")[, select_colnames]
d_ALQ_F <- plyr::rename(d_ALQ_F, c(ALQ140Q = "ALQ141Q", ALQ140U = "ALQ141U"))
d_ALQ_G <- read.xport("data/ALQ_G.xpt")[, select_colnames_1]
d_ALQ_H <- read.xport("data/ALQ_H.xpt")[, select_colnames_1]
d_ALQ_I <- read.xport("data/ALQ_I.xpt")[, select_colnames_1]
d_ALQ_J <- read.xport("data/ALQ_J.xpt")[, select_colnames_2]

# add column Year
d_ALQ_F$Year <- "2009-2010"
d_ALQ_G$Year <- "2011-2012"
d_ALQ_H$Year <- "2013-2014"
d_ALQ_I$Year <- "2015-2016"
d_ALQ_J$Year <- "2017-2018"

# merge data
d_ALQ <- dplyr::bind_rows(d_ALQ_F, d_ALQ_G, d_ALQ_H, d_ALQ_I)
# rename col name
# d_ALQ <- plyr::rename(d_ALQ, c(ALQ130="ALQ130", ALQ140Q="ALQ140Q", ALQ140U="ALQ140U"))

# TODO: Confim
d_ALQ$ALQ142[d_ALQ$ALQ141U == 1 & d_ALQ$ALQ141Q > 2] <- 3
d_ALQ$ALQ142[d_ALQ$ALQ141U == 1 & d_ALQ$ALQ141Q == 2] <- 4
d_ALQ$ALQ142[d_ALQ$ALQ141U == 1 & d_ALQ$ALQ141Q == 1] <- 5

d_ALQ$ALQ142[d_ALQ$ALQ141U == 2 & d_ALQ$ALQ141Q >= 2] <- 6
d_ALQ$ALQ142[d_ALQ$ALQ141U == 2 & d_ALQ$ALQ141Q == 1] <- 7

d_ALQ$ALQ142[d_ALQ$ALQ141U == 3 & (d_ALQ$ALQ141Q >= 7 | d_ALQ$ALQ141Q <= 11)] <- 8
d_ALQ$ALQ142[d_ALQ$ALQ141U == 3 & (d_ALQ$ALQ141Q >= 3 | d_ALQ$ALQ141Q <= 6)] <- 9
d_ALQ$ALQ142[d_ALQ$ALQ141U == 3 & (d_ALQ$ALQ141Q >= 1 | d_ALQ$ALQ141Q <= 2)] <- 10

# get subset and merge
d_ALQ <- subset(d_ALQ, select = -c(ALQ141Q, ALQ141U))
d_ALQ <- dplyr::bind_rows(d_ALQ, d_ALQ_J)


# SMQ 吸烟

select_colnames <- c("SEQN", "SMQ020", "SMD030", "SMQ040", "SMQ050Q", "SMQ050U")

d_SMQ_F <- read.xport("data/SMQ_F.xpt")[, select_colnames]
d_SMQ_G <- read.xport("data/SMQ_G.xpt")[, select_colnames]
d_SMQ_H <- read.xport("data/SMQ_H.xpt")[, select_colnames]
d_SMQ_I <- read.xport("data/SMQ_I.xpt")[, select_colnames]
d_SMQ_J <- read.xport("data/SMQ_J.xpt")[, select_colnames]

# add column Year
d_SMQ_F$Year <- "2009-2010"
d_SMQ_G$Year <- "2011-2012"
d_SMQ_H$Year <- "2013-2014"
d_SMQ_I$Year <- "2015-2016"
d_SMQ_J$Year <- "2017-2018"

# merge data
d_SMQ <- dplyr::bind_rows(d_SMQ_F, d_SMQ_G, d_SMQ_H, d_SMQ_I, d_SMQ_J)
# rename col name
d_SMQ <- plyr::rename(
  d_SMQ,
  c(
    SMQ020 = "smq020", SMD030 = "smd030", SMQ040 = "smq040",
    SMQ050Q = "smq050q", SMQ050U = "smq050u"
  )
)

# BMX 体测数据
select_colnames <- c("SEQN", "BMXHT", "BMXWAIST", "BMXBMI", "BMXWT", "BMXLEG")

d_BMX_F <- read.xport("data/BMX_F.xpt")[, select_colnames]
d_BMX_G <- read.xport("data/BMX_G.xpt")[, select_colnames]
d_BMX_H <- read.xport("data/BMX_H.xpt")[, select_colnames]
d_BMX_I <- read.xport("data/BMX_I.xpt")[, select_colnames]
d_BMX_J <- read.xport("data/BMX_J.xpt")[, select_colnames]

# add column Year
d_BMX_F$Year <- "2009-2010"
d_BMX_G$Year <- "2011-2012"
d_BMX_H$Year <- "2013-2014"
d_BMX_I$Year <- "2015-2016"
d_BMX_J$Year <- "2017-2018"

# merge data
d_BMX <- dplyr::bind_rows(d_BMX_F, d_BMX_G, d_BMX_H, d_BMX_I, d_BMX_J)
# rename col name
d_BMX <- plyr::rename(
  d_BMX,
  c(
    BMXHT = "ht", BMXWAIST = "waist", BMXBMI = "bmi",
    BMXWT = "weight", BMXLEG = "leg"
  )
)


# BPQ



# MCQ
