# RD Challenge

## Sobre

App desafio enviada pela equipe de recrutamento da [RD Station](https://www.rdstation.com/) para preenchimento de vaga de desenvolvedor backend Ruby/Go.
Para resolução do desafio foi escolhida a Linguagem Ruby.

## Nossas expectativas (RD Station)

A equipe de engenharia da RDStation tem alguns princípios onde baseamos nosso trabalho diário. Um deles é: Projete seu código para ser mais fácil de entender, não mais fácil de escrever.

Portanto, para nós é mais importante um código de fácil leitura do que um que utilize recursos arquitetados complexos e desnecessários.

O que gostariamos de ver:

- O código deve ser fácil de ler. [Clean Code](https://medium.com/rd-shipit/clean-code-23580b4e556c) pode te ajudar

- Notas gerais e informações sobre a versão da linguagem e outras informações importantes para executar seu código.

- Código que se preocupa com a performance (Complexidade de Algoritmo)

- O seu código deve cobrir todo os casos de usos presentes no README, mesmo que não haja um teste implementado para tal.

- Você deve enviar o código-fonte da solução para nós como um arquivo contendo apenas a solução de código ou pode fazer o upload da solução para repositórios públicos (GitHub, BitBucket, etc) desde que nos envie o último commit

- Testes. Você pode adicionar novos testes, mas sem alterar o pacote original
## Choose your weapon:
A tecnologia escolhida para resolução do desafio foi Ruby:

-   [Casos de Uso do Desafio com Ruby](ruby/README.md)

-  ~~[JavaScript](javascript/README.md)~~
## Getting Started

Essas instruções fornecerão uma cópia do projeto instalado e funcionando em sua máquina local para fins de desenvolvimento e teste.
### Pré-requisitos

* [Ruby 2.7.2p137](https://www.ruby-lang.org/) - [Instalando o Ruby](https://www.ruby-lang.org/pt/documentation/installation/)
* [Minitest 5.8.4](https://github.com/seattlerb/minitest)

Caso você queira utilizar Docker:

* Docker version 20.10.6, build 370c289 ([instruções para instalação do Docker](https://docs.docker.com/engine/install/))

## Instalação:
Descompactar o arquivo developer_challenges_answers-master.zip ou baixar através o código através do  [repositório no GitHub](https://github.com/rvlaraujo/developer_challenges)

## Rodando a aplicação
### Utilizando Docker
Com o Docker instalado, abra um terminal, vá até a raiz do projeto e execute o comando abaixo para montar o container:
```
docker build -t developer-challange:1.0 .
```
Após a construção do container, execute o comando abaixo para que a saída da suíte de testes seja exibida no termial:
```
docker run -it developer-challange:1.0
```

Caso queeria que o resultado dos testes serem exibidos no arquivo suite_test_output.log, localizado na raíz do projeto, rodar o seguinte comando abaixo:

```
docker run -t developer-challange:1.0 > suite_test_output.log
```
### Sem utilização do Docker
Com Ruby 2.7.2 ou superior instalado em sua máquina, siga os seguintes passos:

- Instalando o bundler:
```
gem install bundler
```

- Instalar as gems necessárias no Gemfile:
```
bundle install
```

- Para executar toda a suíte de testes:
```
rake test TESTOPTS="-v"
```

- Para executar toda um conjunto de testes específico:
```
ruby tests/[nome_do_arquivo_de_testes].rb --verbose
```


## Autores

* **Rafael Viana** - [Rafael's Github](https://github.com/rvlaraujo)