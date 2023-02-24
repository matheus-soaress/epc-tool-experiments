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

Em seguida, na pasta /PPgSI/epc-tool-experiments execute o seguinte comando para fazer o checkout de todas as versões do projeto desejado (o nome do projeto sempre inicia com letra minúscula):

````
./checkout-defects4j.sh <nome-do-projeto>
````

Para executar os testes da JaCoCo e da ba-control-flow execute o seguinte comando (nome do projeto também no mesmo formato do passo anterior):

````
nohup ./get-project-cov.sh <nome-do-projeto> &
````

_Comando nohup (finalizando com "&") é necessário para execução em segundo plano, pois o processo no container docker pode ser "morto" caso o console seja desconectado._

Obs.: Caso queira testar a ba-dua original, há um script para isso, mas o processo de checkout do projeto e da ba-dua não é feito automaticamente. O arquivo get-badua-cov.sh obtém a cobertura da ba-dua original, porém atualmente está configurado para a ba-dua 0.7.1-SNAPSHOT e terá que ser modificado manualmente caso o checkout feito seja de outra versão.

````
./get-badua-cov.sh <nome-do-projeto-conforme-defects4j> <apenas-numero-versao-bug>
````

## Resultados finais (provisório)

Todos os programas com sucesso exceto:

- Closure (versões com falha: 1b, 5b e 106b e algumas versões com suspeita de testes incompletos para ba-control-flow)
- Collections (refazer 27b, pois a execução ficou em espera para a JaCoCo e afetou gravemente o tempo de uma das 10 execuções)
- Compress (erro Jacoco 47b)
- Jackson Databind (erros na ba-control-flow em algumas versões)
- Math (na fila para reteste)
- Mockito (na fila para reteste)
- Time (sugiro refazer teste)

## Problemas atuais

BA-control-flow quando instrumenta o Math, gera erro.

Instrumentação da JaCoCo gera erro na execução do Compress.

~~Erro nas últimas versões do Cli tanto para JaCoCo quanto para ba-control-flow (Ocorre a partir da versão 35b, quando o JUnit3 é substituído pelo JUnit4).~~ [CORRIGIDO]

Mockito recebe erro em algumas versões para as duas ferramentas.

JacksonDatabind com alguns casos de erro na ba-control-flow.

~~Cli e Compress nas versões iniciais usam o JUnit 3 e nas últimas usam o JUnit 4.~~ [CORRIGIDO]

~~Mockito recebe erro em todas as versões quando a JaCoCo é utilizada.~~ [CORRIGIDO]

~~JaCoCo apresenta erro no report ao analisar o arquivo jacoco.exec no projeto JxPath. Suspeita de que o erro seja por analisar bibliotecas que não deveriam ser analisadas e que precisam ser removidas do classpath (pasta /target possui uma pasta /lib)~~ [CORRIGIDO]