library(RColorBrewer)

#'Data source
#'In Colombia exists a website where public entities can publish data
#'for this example i used SIVICAP (index of risk to water quality)
#'2012 https://www.datos.gov.co/Ambiente-y-Desarrollo-Sostenible/SIVICAP/vs2t-i43d
#'2015 https://www.datos.gov.co/Salud-y-Protecci-n-Social/SIVICAP-2015/yjkc-jgd2

#'URL of datasets
URL2012 <- "https://www.datos.gov.co/resource/aktg-7btf.csv"
URL2015 <- "https://www.datos.gov.co/resource/xq6x-vt9y.csv"

#'Because numeric and integer data are wrapped for quotes i used next code to convert it
#'http://stackoverflow.com/a/3611619/1828356
setClass("num.with.commas")
setAs("character", "num.with.commas", function(from) as.numeric(gsub(",", ".", from) ) )

setClass("int.with.quotes")
setAs("character", "int.with.quotes", function(from) as.integer(from) )

#'Read data from file with UTF-8 fileEncoding for preserve accents of names
wqCO2012 <- read.csv("wqCO2012.csv", fileEncoding = "UTF-8", sep = ",", colClasses = c("factor", "character", "factor", "factor", "int.with.quotes", "num.with.commas"))
wqCO2015 <- read.csv("wqCO2015.csv", fileEncoding = "UTF-8", sep = ",", colClasses = c("factor", "character", "factor", "int.with.quotes", "num.with.commas"))

#'Simplify somes names
wqCO2012[wqCO2012$departamento=="Archipiélago de San Andrés. Providencia y Santa Catalina",]$departamento <- "San Andrés y Providencia" 
wqCO2015[wqCO2015$departamento=="Archipiélago de San Andrés Providencia y Santa Catalina",]$departamento <- "San Andrés y Providencia" 

#'Union both dataset every contains one year, garantee the same columns
wqCO2015$nivel_de_riesgo <- as.factor("POR DEFINIR")
waterQualityColombia <- rbind(wqCO2012, wqCO2015)

#'Convert column departamento to factor after simplified the names and union dataset
waterQualityColombia$departamento <- as.factor(waterQualityColombia$departamento)

#'Calculate levels of risk according a policies of goverment
#http://www.invisbu.gov.co/observatorio/eje-transversal/gestion-del-riesgo/agua/item/130-indice-de-riesgo-de-la-calidad-del-agua-para-consumo-humano-irca
levelWQ  <- list(c(0,5,14,35,80,100), c("SIN RIESGO", "BAJO", "MEDIO", "ALTO", "INVIABLE SANITARIAMENTE"))
waterQualityColombia$quality <- cut(waterQualityColombia$promedio_irca, levelWQ[[1]], levelWQ[[2]])
colLevel <- brewer.pal(length(levelWQ[[1]]) - 1, "YlOrRd")
alphaLevel <- 0.30