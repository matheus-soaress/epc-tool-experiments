# Experimentos Edge-pair-tool

Esse repositório contém os scripts utilizados para testar a ferramenta de cobertura de código disponível no seguinte repositório: https://github.com/matheus-soaress/edge-pair-cov-tool

---

## Executando script de teste

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

Para executar os testes da JaCoCo e da ba-control-flow execute o seguinte comando:

````
nohup ./get-project-cov.sh <nome-do-projeto> &
````

_Comando nohup (finalizando com "&") é necessário para execução em segundo plano, pois o processo no container docker pode ser "morto" caso o console seja desconectado._

Obs.: Caso queira testar a ba-dua original, há um script para isso, mas o processo de checkout do projeto e da ba-dua não é feito automaticamente. O arquivo get-badua-cov.sh obtém a cobertura da ba-dua original, porém atualmente está configurado para a ba-dua 0.7.1-SNAPSHOT e terá que ser modificado manualmente caso o checkout feito seja de outra versão.

````
./get-badua-cov.sh <nome-do-projeto> <numero-da-versao-com-bug>
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

## Problemas atuais

BA-control-flow quando instrumenta o Math, gera erro.

Instrumentação da JaCoCo gera erro na execução do Compress.

Mockito recebe erro em algumas versões para as duas ferramentas.

JacksonDatabind com alguns casos de erro na ba-control-flow.