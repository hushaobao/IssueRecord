library(utils)
library(foreign)
library(dplyr)
library(do)
library(survey)
library(openxlsx)
library(reshape2)

setwd("./")

downloads <- function() {
  base_url <- "https://wwwn.cdc.gov/Nchs/Nhanes/"

  for (i in seq_along(years)) {
    for (j in seq_along(data_name)) {
      url <- sprintf("%s%s/%s_%s.xpt", base_url, years[i], data_name[j], suffix[i])
      save_path <- sprintf("data/%s_%s.xpt", data_name[j], suffix[i])
      print(url)
      download.file(url, save_path, mode = "wb")
    }
  }
}


load_and_merge_data <- function(files_path, select_c = c()) {
  datas <- c()
  for (file_path in files_path) {
    year_idx <- which(suffix == strsplit(strsplit(file_path, "_")[[1]][2], ".", fixed = TRUE)[[1]][1])
    # print(file_path)
    data_tmp <- foreign::read.xport(file_path)
    data_tmp$Year <- years[year_idx]
    datas <- append(datas, list(data_tmp))
  }
  data <- dplyr::bind_rows(datas)
  if (!is.null(select_c)) {
    data <- data[, select_c]
  }

  return(data)
}

generate_filelists <- function(basename) {
  filenames <- c()
  for (it in suffix) {
    filename <- sprintf("data/%s_%s.xpt", basename, it)
    filenames <- append(filenames, filename)
  }
  return(filenames)
}

# data_name <- c("DEMO", "BMX", "TCHOL")
data_name <- c("DIQ", "GLU", "BPQ", "MCQ", "PAQ")

years <- c("2009-2010", "2011-2012", "2013-2014", "2015-2016", "2017-2018")
suffix <- c("F", "G", "H", "I", "J")
# download data
# downloads()

# load data
demo_files_path <- generate_filelists("DEMO")
data_demo <- load_and_merge_data(demo_files_path)
print(sprintf("demo num: %d", nrow(data_demo)))

bmx_files_path <- generate_filelists("BMX")
select_c <- c("SEQN", "BMXWT", "BMXHT", "BMXBMI", "BMXLEG", "BMXWAIST", "Year")
data_bmx <- load_and_merge_data(bmx_files_path, select_c)
print(sprintf("bmx num: %d", nrow(data_bmx)))

data_bmx_ <- complete.data(data_bmx)

tchol_files_path <- generate_filelists("TCHOL")
data_tchol <- load_and_merge_data(tchol_files_path)
print(sprintf("tchol num: %d", nrow(data_tchol)))
data_tchol_ <- complete.data(data_tchol)

d <- inner_join(data_demo, data_bmx_, by = c("SEQN", "Year"))
d <- inner_join(d, data_tchol_, by = c("SEQN", "Year"))
print(nrow(d))

diq_files_path <- generate_filelists("DIQ")
d_DIQ <- load_and_merge_data(diq_files_path)

glu_files_path <- generate_filelists("GLU")
d_GLU <- load_and_merge_data(glu_files_path)

bpq_files_path <- generate_filelists("BPQ")
d_BPQ <- load_and_merge_data(bpq_files_path)

mcq_files_path <- generate_filelists("MCQ")
d_MCQ <- load_and_merge_data(mcq_files_path)

paq_files_path <- generate_filelists("PAQ")
d_PAQ <- load_and_merge_data(paq_files_path)

d <- left_join(d, d_DIQ, by = c("SEQN", "Year"))
d <- left_join(d, d_GLU, by = c("SEQN", "Year"))
d <- left_join(d, d_BPQ, by = c("SEQN", "Year"))
d <- left_join(d, d_MCQ, by = c("SEQN", "Year"))
d <- left_join(d, d_PAQ, by = c("SEQN", "Year"))

# ***年龄20岁以上，且非孕妇----
# 人口数据的前提条件，同时满足：
# （1）年龄大于等于20；
# （2）男性或女性非怀孕；
ck <- (d$RIDAGEYR >= 20 & ((d$RIAGENDR == 2 & (d$RIDEXPRG != 1 | is.na(d$RIDEXPRG))) | d$RIAGENDR == 1))
d <- subset(d, ck)
nrow(d) # 24169 reached the standard

# 推测样本代表的人口
d$WTMEC2YR <- d$WTMEC2YR / 5
nhs <- svydesign(
  data = d, ids = ~SDMVPSU, strata = ~SDMVSTRA,
  weights = ~WTMEC2YR, nest = TRUE
)
svytotal(~RIAGENDR, design = nhs, deff = TRUE) # 总人口3.08e+08


d <- left_join(d, d_DIQ, by = c("SEQN", "Year"))
d <- left_join(d, d_GLU, by = c("SEQN", "Year"))
# d <-  left_join(d     ,d_ALQ,  by=c('SEQN','Year'))
# d <-  left_join(d     ,d_SMQ,  by=c('SEQN','Year')) # 数据处理好后再合
d <- left_join(d, d_BPQ, by = c("SEQN", "Year"))
d <- left_join(d, d_MCQ, by = c("SEQN", "Year"))
d <- left_join(d, d_PAQ, by = c("SEQN", "Year"))


# ***糖尿病的判定标准-----
# （1）医生告知有糖尿病,d$diabetes == 1
# （2）医生未告知有糖尿病,但空腹血糖大于125,d$diabetes==2 & d$glu>125
d$STATUS[d$DIQ010.x == 1] <- "yes"
d$STATUS[d$DIQ010.x == 2] <- "no"
d$STATUS[d$DIQ010.x == 2 & d$LBXGLU.x > 125] <- "yes"
# 缺失项去除
d <- subset(d, !is.na(d$STATUS))
print(nrow(d)) # 23546
24169 - 23546 # 623



# 推测样本代表的人口
d$WTMEC2YR <- d$WTMEC2YR / 5
nhs <- svydesign(
  data = d, ids = ~SDMVPSU, strata = ~SDMVSTRA,
  weights = ~WTMEC2YR, nest = TRUE
)
svytotal(~RIAGENDR, design = nhs, deff = TRUE) # 总人口3.08e+08


# ***数据缺失人员分析----------
# 缺失人员信息，
# 确实人员的组成，按种族分类
data_demo$RIDRETH1 <- recode(data_demo$RIDRETH1,
  "1" = "mexican",
  "2" = "other",
  "3" = "white",
  "4" = "black",
  "5" = "other"
)
demo_miss <- data_demo[!data_demo$SEQN %in% d$SEQN, ]
# 不符合要求的总人数
nrow(demo_miss) # 26147


ethdf <- as.data.frame(table(Eth = demo_miss$RIDRETH1))
ethdf <- transform(ethdf, cumFreq = cumsum(Freq), FreqRate = prop.table(Freq))
ethdf <- transform(ethdf, cumFreqRate = cumsum(FreqRate))
ethdf <- transform(ethdf, FreqRate = round(FreqRate * 100, 2), cumFreqRate = round(cumFreqRate * 100, 2))
ethdf



# * Figure1 糖尿病的近十年发病率趋势,种族、年龄、性别、教育、收入因素的指标差异-------
# 将数据内容对应转化
d$RIDRETH1 <- recode(d$RIDRETH1,
  "1" = "mexican",
  "2" = "other",
  "3" = "white",
  "4" = "black",
  "5" = "other"
)
d$RIAGENDR <- recode(d$RIAGENDR, "1" = "Male", "2" = "Female")


# 加权,重新计算nhs
d$RIDRETH1 <- factor(d$RIDRETH1, levels = c("black", "white", "mexican", "other"))
d$RIAGENDR <- factor(d$RIAGENDR, levels = c("Male", "Female"))
d$STATUS <- factor(d$STATUS, levels = c("yes", "no"))
nhs <- svydesign(
  data = d, ids = ~SDMVPSU, strata = ~SDMVSTRA,
  weights = ~WTMEC2YR, nest = TRUE
)



res <- svyby(~STATUS, ~Year, nhs, svymean)
res
res <- round(as.data.frame(res[2]) * 100, 1)
res
write.xlsx(res, "results/Figure1-stauts~year.xlsx", append = TRUE, rowNames = TRUE)
# 各年数据的差异性
svyglm(STATUS ~ Year, design = nhs, family = binomial) |> summary()

# Year+eth
res <- svyby(~STATUS, ~ Year + RIDRETH1, nhs, svymean) |> dcast(Year ~ RIDRETH1, value.var = "STATUSyes")
res
res <- round(as.data.frame(res[2:4]) * 100, 1)
res
write.xlsx(res, "results/Figure1-stauts~Year+RIDRETH1.xlsx", append = TRUE, rowNames = TRUE)
# 各年数据的差异性
svyglm(STATUS ~ Year + RIDRETH1, design = nhs, family = binomial) |> summary()

# Year+sex
# 将sex数据内容对应转化
d$sex <- recode(d$RIAGENDR, "1" = "Male", "2" = "Female")
nhs <- svydesign(
  data = d, ids = ~SDMVPSU, strata = ~SDMVSTRA,
  weights = ~WTMEC2YR, nest = TRUE
)
res <- svyby(~STATUS, ~ Year + RIAGENDR, nhs, svymean) |> dcast(Year ~ RIAGENDR, value.var = "STATUSyes")
res
res <- round(as.data.frame(res[2:3]) * 100, 1)
res
write.xlsx(res, "results/Figure1-stauts~year+sex.xlsx", append = TRUE, rowNames = TRUE)
# 各年数据的差异性
svyglm(STATUS ~ Year + RIAGENDR, design = nhs, family = binomial) |> summary()


# Year+age50
# 年龄分段
bu_x <- d$RIDAGEYR
labels <- c("<50", ">=50")
breaks <- c(0, 50, 100)
d$age50 <- cut(bu_x, breaks = breaks, labels = labels, right = FALSE)
# 设置序列顺序
d$age50 <- factor(d$age50, levels = c("<50", ">=50"))
nhs <- svydesign(
  data = d, ids = ~SDMVPSU, strata = ~SDMVSTRA,
  weights = ~WTMEC2YR, nest = TRUE
)
res <- svyby(~STATUS, ~ Year + age50, nhs, svymean) |> dcast(Year ~ age50, value.var = "STATUSyes")
res
res <- round(as.data.frame(res[2:3]) * 100, 1)
res
write.xlsx(res, "results/Figure1-stauts~year+age50.xlsx", append = TRUE, rowNames = TRUE)
# 各年数据的差异性
svyglm(STATUS ~ Year + age50, design = nhs, family = binomial) |> summary()
