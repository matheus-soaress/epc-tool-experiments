# Experimentos Edge-pair-tool

Esse repositório contém os scripts utilizados para testar a ferramenta de cobertura de código disponível no seguinte repositório: https://github.com/matheus-soaress/edge-pair-cov-tool

---

## Criando container Docker

Na pasta dockerfile execute o seguinte comando para montar a imagem Docker usada para rodar os testes:

````
docker build -t epc-tool-experiments .
````

Em seguida inicie o container Docker usando o comando:

````
docker container run -i --name epc-tool-container epc-tool-experiments
````

Para reiniciar o container parado use o comando:

````
docker container start epc-tool-container
````

Para acessar o console do container use o comando:

````
docker exec -it epc-tool-container /bin/bash
````

Em seguida, na pasta /PPgSI/epc-tool-experiments execute o seguinte comando para fazer o checkout de todas as versões do projeto desejado:

````
./checkout-defects4j.sh <nome-do-projeto>
````

## Obtendo relatórios sobre o desempenho das ferramentas

Para executar os testes da JaCoCo e da ba-control-flow obtendo os tempos de execução execute o seguinte comando:

````
nohup ./get-project-cov.sh <nome-do-projeto> &
````

_Comando nohup (finalizando com "&") é necessário para execução em segundo plano, pois o processo no container docker pode ser "morto" caso o console seja desconectado._

O comando acima gera um arquivo .csv na pasta /PPgSI/perf-reports com nome no seguinte formato: 

> `<nome-do-projeto>`**-**`<tipo-de-cobertura>`.csv

O tipo de cobertura no nome do arquivo pode ser: 

1. jacoco: tempos de execução da ferramenta JaCoCo;
2. node: tempo de execução da ferramenta ba-cf apenas para cobertura de nós e linhas;
3. edge: tempo de execução da ferramenta ba-cf apenas para cobertura de arestas;
4. edge-pair: tempo de execução da ferramenta ba-cf apenas para cobertura de pares de arestas.

O arquivo contém o 10 tempos de execução de cada versão do projeto executado. Executando 10 vezes, conseguimos obter uma média de tempo de execução. Cada linha dentro do arquivo.csv terá o seguinte formato:

> execucao versao `<numero-da-versao>`b;`<tempo-execução-1>`;{...};`<tempo-execução-10>`;

Além do arquivo .csv contendo os tempos de execução, também é gerado um arquivo .xml, na pasta /PPgSI/perf-reports, contendo um relatório de cobertura para cada versão de cada projeto executado. 

## Obtendo um relatório geral sobre cobertura de código

Para obter um relatório geral sobre a cobertura de código dos relatórios .xml que estão na pasta /PPgSI/perf-reports execute o seguinte comando:

```
.\get-req-reports.sh
```

O comando acima gera arquivos .csv agrupando os dados de cobertura de todos os projetos na mesma pasta em que se encontram os relatórios .xml. Cada arquivo .csv contém 4 colunas: nome do projeto, versão, quantidade de requisitos não cobertos e quantidade de requisitos cobertos. Os requisitos de teste rastreados para cada ferramenta são:

| JaCoCo          |  BA-CF (node) | BA-CF (edge)  | BA-CF (edge-pair) |
| --------------- | ------------- | ------------- | ----------------- |
| classe          | classe        | classe        | classe            |
| método          | método        | método        | método            |
| linha           | linha         |               |                   |
| instrução       |               |               |                   |
| aresta (branch) |               | aresta (edge) |                   |
| complexidade    |               |               |                   |
|                 | nó            |               |                   |
|                 |               |               | par de arestas    |

### Obtendo **apenas** os relatórios de cobertura

Os relatórios de cobertura podem ser obtidos executando o script de coleta de dados de desempenho, mas nesse script cada versão de um projeto é executada 10 vezes. Para agilizar a obtenção dos relatórios de cobertura, é possível executar cada versão de cada projeto apenas uma vez por meio do comando a seguir:

````
./get-project-reports.sh <nome-do-projeto>
````

## Projetos do Defects4j disponíveis

- Chart 
- Cli 
- Closure 
- Codec 
- Collections 
- Compress
- Csv
- Gson
- JacksonCore
- JacksonDatabind
- JacksonXml
- Jsoup
- JxPath
- Lang
- Math
- Mockito
- Time