
library(pointblank) 
library(rio)
library(dplyr)

#### Tabela: State ####

state_pops <- import("https://raw.githubusercontent.com/franciscofdpr/Dicionario-de-Dados/main/states.csv")

state_informant <- create_informant(state_pops, lang = "pt",
                                 tbl_name = "states.csv", 
                                 label = "Dados do Censo dos EUA")

tbl_state <- state_informant %>%
  info_tabular(
    Description = "Tabela das populações dos estados dos EUA de censos decenais, com dados de 2000, 2010 e 2020, 
                   bem como colunas para mudanças percentuais e regiões e divisões do Census Bureau.",
    Updates = "Atualizado semestralmente. Ultima atualização Dez-2024",
    Source = "US Census Bureau and the R tidycensus package",
    Stored = "[Repositório GitHub de dados](https://github.com/franciscofdpr/Dicionario-de-Dados/tree/main)",
   `Used by` = "Do More with R")%>%
  info_columns(
    columns = "State",
    info = "Nome em texto completo do estado, como Havaí ou Alasca.")%>%
  info_columns(
    columns = "Pop_2000",
    info = "É a população média do estado do Censo 2000.") %>%
  info_columns(
    columns = "Pop_2010",
    info = "É a população média do estado do Censo 2010.") %>%
  info_columns(
    columns = "Pop_2020",
    info = "É a população média do estado do Censo 2020.") %>%
  info_columns(
    columns = c("PctChange_2000", "PctChange_2010", "PctChange_2020"),
    info = c("Alteração percentual da população em relação ao censo decenal anterior. Formato já multiplica o decimal
              por 100, então, por exemplo, uma mudança de 10,1% é representada como o número 10,1."))%>%
  info_columns(
    columns = "State Code",
    info = "Abreviatura de estado com duas letras, como HI ou AK.")%>%
  info_snippet(
    "census_regions",
    fn = snip_list("Region", limit = 10, sorting = "inseq")) %>%
  info_columns(
    "Region",
    info = "Regiões do Censo. Valores possíveis: {census_regions}") %>%
  info_snippet(
    "census_divisions",
    fn = snip_list("Division", limit = 10, sorting = "inseq")) %>%
  info_columns(
    "Division",
    info = "Divisões do Censo. Valores possíveis: {census_divisions}") %>%
incorporate()

#### Tabela: Temperature ####

bos_temps <- import("https://raw.githubusercontent.com/franciscofdpr/Dicionario-de-Dados/main/BOS_temperatures.csv")

temperature_informant <- create_informant(bos_temps, lang = "pt",
                                          tbl_name = "BOS_temperatures.csv", 
                                          label = "Dados meteorológicos")

tbl_temperatura <- temperature_informant %>%
  info_tabular(
    Description = "Tabela de temperaturas altas e baixas diárias de Boston, bem como mínimas, máximas,
                   e temperaturas médias. Dados não oficiais do Serviço Meteorológico Nacional.",
    Updates = "Atualizações diarias",
    Source = "[Iowa State University's Iowa Environmental Mesonet METAR database](https://mesonet.agron.iastate.edu/request/download.phtml?network=MA_ASOS)",
    Stored = "[Repositório GitHub de dados](https://github.com/franciscofdpr/Dicionario-de-Dados/tree/main)",
    `Used by` = "Do More with R") %>%
  info_columns(
    columns = "station",
    info = "Nome do estado")%>%
  info_columns(
    columns = "day",
    info = "Dia das medições de temperatura")%>%
  info_columns(
    columns = "max_temp_f",
    info = "Temperatura máxima medida")%>%
  info_columns(
    columns = "min_temp_f",
    info = "Temperatura minima medida")%>%
  info_columns(
    columns = "min_feel",
    info = "Sensação minima medida")%>%
  info_columns(
    columns = "max_feel",
    info = "Sensação média medida")%>%
  info_columns(
    columns = "avg_feel",
    info = "Sensação média medida")%>%
  info_columns(
    columns = "climo_high_f",
    info = "Clima alto")%>%
  info_columns(
    columns = "climo_low_f",
    info = "Clima baixo")%>%
  info_columns(
    columns = "Month",
    info = "Mês em que as medições são realizadas")%>%
  info_columns(
    columns = "Year",
    info = "Ano em que as medições são realizadas")%>%
  info_columns(
    columns = "Day",
    info = "Dia em que as medições são realizadas")%>%
  info_columns(
    columns = "MonthDay",
    info = "Mês e dia em que as medições são realizadas")%>%
  incorporate()

#### Tabela: Energia ####

ear <- import("https://raw.githubusercontent.com/franciscofdpr/Dicionario-de-Dados/main/uf.csv")

state_informant <- create_informant(ear, lang = "pt",
                                    tbl_name = "uf.csv", 
                                    label = "Energia armazenada (EAR)")

tbl_energia <- state_informant %>%
  info_tabular(
    Description = "Tabela de dados das grandezas de energia armazenada (EAR) em periodicidade diária. 
                   A Energia Armazenada (EAR) representa a energia associada ao volume de água disponível nos 
                   reservatórios que pode ser convertido em geração na própria usina e em todas as usinas 
                   à jusante na cascata. A grandeza de EAR leva em conta nível verificado nos reservatórios 
                   na data de referência.",
    Source = "[Operador Nacional do Sistema Elétrico (ONS)](https://basedosdados.org/dataset/0a54258d-4adc-4fa9-a7c8-8e39426d22a2?table=d4185bb5-7aeb-41f1-9bcd-e081f7eb8abc)",
    Stored = "[Repositório GitHub de dados](https://github.com/franciscofdpr/Dicionario-de-Dados/tree/main)",
    `Used by` = "Do More with R")%>%
  info_columns(
    columns = "ano",
    info = "Ano da medição")%>%
  info_columns(
    columns = "mes",
    info = "Mês da medição")%>%
  info_snippet(
    "siglas",
    fn = snip_list("sigla_uf", limit = 30, sorting = "inseq")) %>%
  info_columns(
    "sigla_uf",
    info = "Siglas dos estados. Valores possíveis: {siglas}") %>%
  info_snippet(
    "consumos",
    fn = snip_list("tipo_consumo", limit = 10, sorting = "inseq")) %>%
  info_columns(
    "tipo_consumo",
    info = "Tipos de consumo de energia. Valores possíveis: {consumos}") %>%
  info_columns(
    columns = "numero_consumidores",
    info = "Número de consumidores")%>%
  info_columns(
    columns = "consumo",
    info = "Quantidade de energia consumnida")%>%
  incorporate()
  