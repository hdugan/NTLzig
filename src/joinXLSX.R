library(xlsx)



temp = list.files('data/', pattern="*.csv", full.names = T)
myfiles = lapply(temp, read.delim)

names = str_split(list.files('data/'), '.csv')
names = tools::file_path_sans_ext(names)

# Use data from the question
for (i in seq_along(temp)) {
  write.xlsx(x = temp[i], 
             file = "data/NTL_zig.xlsx", 
             sheetName = names[i],
             append = TRUE)
}
