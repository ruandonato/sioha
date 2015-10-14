### Universida de Brasília - FGA
### Disciplina: Técnicas de Programação Turma: A - 2/2015
### Professor: Maurício Serrano
### Alunos: 
#### Dylan Guedes - 12/0115727
#### Gustavo Araujo - 11/0061250
#### Ruan Donato - 11/0139755
#### Victor Henrique -13/0145700




# Documento de Estilo - Sioha

## Sumário
1. [Introdução](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#1-introdução)
2. [Inspirações para os padrões](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#2-inspirações-para-os-padrões)
3. [Indentação e padrões de texto](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#3-indentação-e-padrões-de-texto)
4. [Métodos](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#4-métodos)
5. [Strings](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#5-strings)
6. [Routes](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#6-routes)
7. [Hashs](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#7-hashs)
8. [Curly Braces (Chaves)](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#8-curly-braces-chaves)
9. [Arrays (Colchetes)](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#9-arrays-colchetes)
10. [Migrates (Migrações)](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#10-migrates-migrações)
11. [Estrutura das classes](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#11-estrutura-das-classes)
12. [Métodos e atributos privados (Private)](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#12-métodos-e-atributos-privados-private)
13. [Estilo do HTML](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#13-estilo-do-html)
14. [Estilo do SASS/CSS](https://github.com/SiohaTecProg/sioha/blob/master/code_stylesheet.md#14-estilo-do-sasscss)

## 1. Introdução
Em um projeto de software, independente de sua magnitude, é ideal que ele seja construído da melhor maneira possível. Dentre as diversas coisas 
que afetam esta construção, está abrigado a qualidade do código. A qualidade do código tange vários aspectos, que vão desde o estilo do código (foco desse documento),
quanto em boas técnicas de programação, otimizações, dentre outras coisas.

Desse modo, este documento tem como objetivo trazer o padrão de estilo de código que deve ser seguido no **Sioha**. Ao todos os desenvolvedores seguirem o mesmo padrão,
a leitura e visuabilidade do código fica mais uniforme, melhorando assim a experiência do programador.

## 2. Inspirações para os padrões
As escolhas feitas para o estilo do código evidentemente não foram criadas do zero. Foram inspiradas por diversas fontes. Dentre estas fontes, estão:
O estilo utilizando pela comunidade Ruby em si (pode ser comparado com as respostas relativas no Stack Overflow), com o livro [Rails Tutorial](https://www.railstutorial.org/book), escrito por Michael Hartl,
o livro (Ruby Metaprogramming)[https://pragprog.com/book/ppmetr2/metaprogramming-ruby-2], o software (Noosfero)[https://github.com/noosfero/noosfero], dentre outros.

## 3. Indentação e padrões de texto
Estes itens são completamente configurados em qualquer editor de texto/IDE decentes. Os padrões utilizados são os mesmos utilizados pela comunidade Ruby,
ressaltados no livro (Eloquent Ruby)[http://www.amazon.com/Eloquent-Ruby-Addison-Wesley-Professional-Series/dp/0321584104].

### Padrões:
 1. Indent Using Spaces: **true**
 2. Tab Width: **2**
 
## 4. Métodos
### Uso do parêntese
+ Caso a função não receba parâmetros, não deverão ser utilizados parênteses
+ Sempre que no parâmetro for utilizado uma Hash de atributos (exemplo: **email: @user.email**), deve ser utilizado parênteses.
+ Sempre que for chamado um método para o retorno da função (exemplo: **user.find(2).name**), deverá ser utilizado parênteses
+ Sempre que a ultima letra do nome do método for o carácter **=**, deverá ser utilizado parênteses. (Exemplo: **def current_user=(user))
+ Qualquer outro caso não citado, não deverá utilizar parênteses.
+ Sempre deve haver uma quebra de linha antes e após o método

## 5. Strings
+ Sempre que na string for utilizado <b>#{ }</b>, deverá ser utilizado aspas dupla. Em qualquer outro caso, deverá ser utilizado aspas simples. Exemplos:
1. **"#{@user.name}"**
2. **'Invalid Combination.'**

## 6. Routes
+ Nos resources, só deverão ser possíveis rotas que estejam prontas e estáveis. As rotas que não são possíveis devem ser filtradas utilizando o comando **only**.
+ A síntaxe de rotas deve utilizar o símbolo **=>**, exemplo: **get '/signin' => 'sessions#new'
+ Deverá ser utilizado aspas simples para os nomes

## 7. Hashs
+ A hash deverá sempre ser acessada através de dois-pontos **:**, ao invés de **=>**. Exemplo:
**get :index, user: @user**

## 8. Curly Braces (Chaves)
+ Sempre deve haver um espaço após o início da chave, e um antes de terminar. Exemplo:
** user: { name: @user.name, email: @user.email } **

## 9. Arrays (Colchetes)
+ Sempre deve haver um espaço após a vírgula

## 10. Migrates (Migrações)
+ Deverão sempre ser geradas via **rails generate**, por conta do id unico.

## 11. Estrutura das classes
+ Sempre deve haver uma quebra de linha após a declaração da classe, e uma antes do final da classe (do ultimo end)
+ Sempre deve haver um espaço antes e depos da herança (exemplo: **CreateUsers < ActiveRecord::Migration**

## 12. Métodos e atributos privados (Private)
+ deve haver uma quebra de linha antes e depois da declaração do **Private**
* Não deve haver nível de indentação nos itens dentro do private.

## 13. Estilo do HTML
+ Sempre deve haver um espaço após o início, e um antes do final, na utilização do embedded-ruby (Exemplo: **<%= a.name %>**)
+ Os mesmos padrões válidos para os arquivos .rb já citados também valerão para os arquivos .html
+ Caso não exceda o limite de 80 carácteres (colunas), as tags deverão ficar na mesma linha que o conteúdo. Exemplo:
**<li><%= link_to 'users', users_path %></li>**

## 14. Estilo do SASS/CSS
+ Deve haver um espaço antes das chaves. Exemplo:
** .users-new { padding: 40px; } **
+ O mesmo estilo utilizado em arquivos .rb deve ser utilizado em arquivos .css e SASS

## 15. Estilo do cabeçalho
+ Deve haver sempre o nome do arquivo
+ Deve haver sempre o propósito deste arquivo
+ Deve haver sempre o nome da licença
+ Deve haver sempre o nome do projeto
+ Deve haver sempre o nome da faculdade.

Exemplo:
![Exemplo de Cabeçalho](http://i.imgur.com/wVedyM5.png)

## 16. Estilo dos comentários
+ Os comentários devem sempre começar com letra minúscula.
+ Deve haver sempre um espaço depois de iniciado o comentário.
+ Os comentários só devem começar com letra maiúscula no cabeçalho de arquivo
