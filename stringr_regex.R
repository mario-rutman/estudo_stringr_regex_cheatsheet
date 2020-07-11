library(stringr)
library(glue)
library(tidyverse)


# String: sequência de caracters entre aspas (simples ou duplas).
# Tanto faz usar aspas duplas ou únicas.


'a character string using single quotes'
"a character string using double quotes"


# Criando vetores de character vazios.
char_vector <- character(0)


# Agora preenchendo o char_vector.
char_vector[2] <- 'coisa'
char_vector[5] <- 'tio'
char_vector[3] <- 'pincel'
print(char_vector)


# Tamanho do vetor.
length(char_vector)


# Colar.
paste('I', 'Love', 'R', sep = '-')
paste("The Life of", pi, sep = ' ')
paste('Casa', 1:5, sep = '.')
paste('Casa', c("jaca", "amor", "lem"), sep = '***')
paste('Casa', c("jaca", "amor", "lem"))
paste('Casa', "jaca", "amor", "lem")
paste(1:3, c("!", '&','*'), sep = '', collapse = '')
paste(1:3, c("!", '&','*'), sep = '')
paste(1:3, c("!", '&','*'), sep = '  ')
paste(1:3, "!", '&','*')

# Colar colapsando: pasteo.
paste0("let's", "collapse", "all", "these", "words.")
paste0('Vamos', 'colapsar', 'todas', 'estas', 'palavras.')

# Tem uma pacote novo, o glue, que faz o mesmo papel do paste, porém baseado no equivalento do Python,
# que é bastante simplificado.
# O objetivo aqui é usar e criar exemplos do uso do glue.
# O glue é uma versão para R da forma como se concatemam strings no Python.
# Tinha mesmo que ser imitada, é muito boa!

library(glue)

nome <- "Anita"
idade <- 14
aniversario <- as.Date("2021-02-11")
glue('Meu nome é {nome},', 
     ' minha idade ano que vem será {idade + 1} anos,', 
     ' meu aniversário cai numa {format(aniversario, "%A, %B %d, %Y")}.')

glue('Meu nome é {nome},', 
     ' minha idade ano que vem será {idade + 1}. Em {format(aniversario, "%Y")} 
      meu aniversário cairá numa {format(aniversario, "%A")}.')

# Tal qual no Python basta ter uma aspa no início e outra no fim.
glue('Meu nome é {nome}, minha idade ano que vem será {idade + 1} anos. Em {format(aniversario, "%Y")} 
      meu aniversário cairá numa {format(aniversario, "%A")}.')

# As variáveis podem ficar dentro da função glue.
glue('Meu nome é {nome}, minha idade ano que vem será {idade + 1}. Em {format(aniversario, "%Y")} 
      meu aniversário cairá numa {format(aniversario, "%A")}.', 
     nome = "Alice",
     idade = 12, 
     aniversario = as.Date("2021-09-29"))

# Named arguments can be used to assign temporary variables.
glue('My name is {name},',
     ' my age next year is {age + 1},',
     ' my anniversary is {format(anniversary, "%A, %B %d, %Y")}.',
     name = "Joe",
     age = 40,
     anniversary = as.Date("2001-10-12"))

# Podemos ainda usar a glue na criação de uma função.
intro <- function(name, profession, country){
  glue("Meu nome é {name}, sou {profession} {country}")
}

intro("Maria", "defensora pública", "no Brasil")
intro("Mário", "auditor fiscal", "no Brasil")
intro('Alice', 'veterinária', 'no Brasil')
intro('Anita', 'jornalista', 'em Portugal')


# A glue aceita o pipe ( %>%).
mtcars %>% glue_data("O {rownames(.)} tem {hp} hp")

# Você pode criar uma coluna de frases. É sensacional!!!
# Já pode fazer o tibble com os textos que usará no relatório.
flores <- iris %>%
  mutate(descr = glue("O tamanho da pétada da {Species} é {Petal.Length}"))


glue_collapse(glue("{1:10}"))

# Wide values can be truncated
glue_collapse(glue("{1:10}"), width = 8)

# Essa é bem legal!
glue_collapse(1:4, ", ", last = " and ")

# No glue a colagem mantém a formatação.
glue("
A formatted string
    Can have multiple lines
with additional indention preserved
")

glue("
     \\ntrailing or leading newlines can be added explicitly\\n
     ")

# Aqui junta textos que estão em linhas diferentes.
glue("
A formatted string \\
can also be on a \\
single line
")

# Quantos caracteres?
nchar(c("How", "many", "characters?"))
nchar("How many characters?")

# Quantos elementos?
length(c("How", "many", "characters?"))
length("How many characters?")

# Tudo em minúscula:to lower case
tolower(c("aLL ChaRacterS in LoweR caSe", "ABCDE"))

# Tudo em maiúscula: to upper case
toupper(c("All ChaRacterS in Upper Case", "abcde"))

# Trocando os caracteres de um character.
# chartr(o antigo, o novo, x)
chartr("a", "A", "This is a boring string")
chartr('l', 'b','Ela é louca pela lua')

# Múltiplas trocas.
crazy <- c("Here's to the crazy ones", "The misfits", "The rebels")
chartr("aei", "#!?", 'crazy') # troca o a por #, o e por ! e o i por ?

# Abreviação: serve para os nomes ficarm menores.
some_colors <- colors()[1:4]
abbreviate(some_colors)
abbreviate(some_colors, minlength = 5)
abbreviate(some_colors, minlength = 4, method = "both.sides")


# Operações com conjuntos.
# União.
set1 <- c("some", "random", "words", "some")
set2 <- c("some", "many", "none", "few")
union(set1, set2)

# Interceção.
set3 <- c("some", "random", "few", "words")
set4 <- c("some", "many", "none", "few")
intersect(set3, set4)

# Diferença: o que está no 1º e não está no 2º.
set5 <- c("some", "random", "few", "words")
set6 <- c("some", "many", "none", "few")
setdiff(set5, set6)
setdiff(set6, set5)

# Dois conjuntos são iguais? Não importa a ordem em que e encontram.
set7 <- c("some", "random", "strings")
set8 <- c("some", "many", "none", "few")
set9 <- c("strings", "random", "some")
setequal(set7, set8)
setequal(set7, set9)


# Dois conjuntos são idênticos? Considera a ordem.
identical(set7, set7)
identical(set7, set9)


# Certo elemento está em um conjunto?
set10 <- c("some", "stuff", "to", "play", "with")
elem1 <- "play"
elem2 <- "crazy"

elem2 %in% set10
elem1 %in% set10
c('a', 'b', 'c') %in% c('a', 'j', 'b')
c('a', 'j', 'b') %in% c('a', 'b', 'c')

# Stringr package.
library(stringr)
library(htmlwidgets) #Para usar o str_view()

# Começam sempre com 'str_'
# Colar. 
str_c("May", "The", "Force", "Be", "With", "You")
str_c(letters, collapse = "") 
str_c("May", "The", "Force", NULL, "Be", "With", "You", character(0))
str_dup(fruit, times = 2) # Duplica os strings individualmente.
str_split_fixed(fruit, " ", n = 2) # Separa em duas colunas os nomes compostos. Quando tem um nome só nada acontece.
str_glue("Pi is {pi}") # Cria uma frase a apartir de strings.
str_glue_data(mtcars, "{rownames(mtcars)} has {hp} hp") # Cria frases a partir de dataframes.

# Conta o número de caracteres.
some_text <- c("one", "two", "three", NA, "five")
str_length(some_text)


# Convertendo um vetor para factor.
# Ontem ('2020-07-06') faleceu o Ennio Morricone. Segue minha R-omenagem.
some_factor <- factor(c(1,1,1,2,1,2,1,3,1,1,2,3), labels = c("O bom,", "o mau", "e o feio."))
some_factor

# Verificando os tamanhos de some_factor.
str_length(some_factor)

# String: sequência de caracters entre aspas (simples ou duplas).

# fruit vetor com 80 elementos no pacote stringr.
glimpse(fruit)

# 
str_detect(fruit, 'a')
str_which(fruit, "a")
str_count(fruit, "a")
str_locate(fruit, "a")
str_length(fruit)
str_sub(fruit, 1, 3) # Escolhe do 1º ao 3º caracter.
str_sub(fruit, -2) # Escolhe do último ao penúltimo caracter.
str_sub(object, -3, -1) # Escolhe do último ao antepenúltimo.
str_subset(fruit, "b") # Escolhe as palavras que têm o caracter 'b'.
str_subset(fruit, "pea") # Escolhe as palavras que têm o caracter 'pea'.
str_subset(fruit, "ui") # Escolhe as palavras que têm o caracter 'ui'.
str_subset(fruit, "berry")

str_subset(fruit, " berry")
str_subset(fruit, "  berry")
str_extract(fruit, "[aeiou]")


names <- c("Keisha", "Mohammed", "Jane", 'Anita', 'Alice', 'Mammmmeixa', 'Wilson', 'Márcia')
str_sort(names) #Coloca em ordem alfabética.
str_view(names, "^M") #identify strings that start with "M"
str_view(names, 'a$') #identifica strings que terminam com 'a' minúsculo.
str_count(names, "^M") # conta em cada palavra os nomes que começam com M
str_count(names, "m") # conta em cada palavra quantos 'm' tem.
sum(str_count(names, 'a$')) # soma os nomes que terminam com 'a'.

colors <- c('red','orange','yellow','green','Blue','violet','#C8C8C8','#000000')
str_detect(colors, '\\d')
str_subset(colors, '^[a-z]') # faz um subconjunto dos elementos que começam com letra minúscula.
str_view_all(colors, "\\d+[A-Z]+")
str_count(colors, '[a-zA-Z]') # conta o número de letras maiúsculas ou minúsculas. 
str_view_all(colors, '^#') # string que começa com #.
str_view_all(colors, '[a-z]') # mostra as letras minúsculas das .


# Mostra onde estão as vogais.
str_view_all('Hoje é dia de esfiha!', "[aeiou]")

# identify anything that's NOT a lowercase vowel
str_view_all('Aqui mostra tudo que não é aeiou em minúsculas.', "[^aeiou]")

endereços <- c("1234 Main Street", "1600 Pennsylvania Ave S/A", "Brick Buildinnnng")
# identify anything that's a digit
str_view_all(endereços, "\\d")

# identify any whitespace
str_view_all(endereços, "\\s")

# identify any character
str_view_all(endereços, ".")

str_view_all(endereços, "S/A")


# Regular Expressions - Regex
# ? : 0 or 1
# + : 1 or more
# \* : 0 or more
# {n} : exactly n times
# {n,} : n or more times
# {n,m} : between n and m times

# "[aeiou]" : matches a, e, i, o, or u
# "[^aeiou]": matches anything other than a, e ,i , o, or u
# "\d" : matches any digit
# "\s" : matches any whitespace (space, tab, newline)
# "." : matches any character (except a newline)


## identify any time n shows up one or more times
str_view_all(endereços, "n+")

## identify any time n shows up
str_view_all(endereços, "n{1}")

## identify any time n shows up exactly two times in a row
str_view_all(endereços, "n{2}")

## identify any time 'nn' shows up one or more times 
str_view_all(endereços, "nn+")

## identify any time n shows up two or three times 
str_view_all(endereços, "n{2,3}")

## identify any time n shows up three or four times 
str_view_all(endereços, "n{3,4}")

sentences <- "Montreal, é prá lá que vou com Maria, Anita e Alice."
str_to_lower(sentences)
str_to_upper(sentences)
str_to_title(sentences)


str_replace(fruit, "a", "X-X") # Só troca o primeiro que aparece.
str_replace(c('terra', 'casa', 'texto', 'carro'), 't', '$') 
str_replace(c('terra', 'casa', 'texto', 'carro'), 'ca', '*****') 
str_replace_all(fruit, "a", "T") # Troca todos.
str_replace_all(c('terra', 'casa', 'texto', 'carro', 'banana'), 'a', 'OSCAR')

# Este é bom para fazer muitas trocas.
frutas <- c("one apple", "two pears", "three bananas")
frutas %>%
  str_replace_all(c("one" = "um", "two" = "2", "three" = "três"))

shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(shopping_list, "\\d")
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
str_extract(shopping_list, "\\b[a-z]{1,4}\\b")

# Extract all matches
str_extract_all(shopping_list, "[a-z]+")
str_extract_all(shopping_list, "\\b[a-z]+\\b")
str_extract_all(shopping_list, "\\d")


# Para usar o str_view é necessário o pacote htmlwidgets.
library(htmlwidgets)

# Vou usar o str_view_all para ver os significados dos regex.
# A  parte marcada seria  o resultado do str_extract_all()

str_view_all("abc ABC 123\t.!?\\(){}\n", "a")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\.")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\!")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\?")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\(")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\)")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\\\")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\{")
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\}") #Em suma:o símbolo depois de \\ é marcado/extraído.
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\n") #Nova linha.
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\t") #t de tab, que é maior que simples espaço.
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\s") #s de space, espaço.
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\d") #d de dígito, número inteiro.
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\w") #w letra  e  número.


#Quando usamos o formato [:alguma palavra:] nos inserimos numa classificação.
# Existem espaço e escrita: [:space:] ou [:graph:].
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:space:]") #É nova linha, espaço ou tab.
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:blank:]") #É só espaço ou tab.
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:graph:]") #É tudo que não é space, i.é. qualquer escrita.

#[:graph:] pode ser [:punct:] ou [:alnum:].
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:punct:]") #Pontuação só espaço ou tab.
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:alnum:]") #Alfabético ou numérico.

#[:alnum:] pode ser [:digit:] ou [:alpha:].
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:digit:]") #Números.
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:alpha:]") #Letras.

#[:alpha:] pode ser [:lower:] ou [:upper:].
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:lower:]") #Pontuação só espaço ou tab.
str_view_all("abc ABC 123\t.!?\\(){}\n", "[:upper:]") #Alfabético ou numérico.

#Por fim o ponto ., que engloba tudo menos nova linha. 
str_view_all("abc ABC 123\t.!?\\(){}\n", "\\n") #Nova linha.
str_view_all("abc ABC 123\t.!?\\(){}\n", ".") #Tudo que não é nova linha.

# ou
str_view_all("abcde", "ab|d")
str_view_all("abcde", "a|d")

# um dos...
str_view_all("abcde", "[abe]")
str_view_all("abcde", "[ace]")

# tudo menos...
str_view_all("abcde", "[^ace]")
str_view_all("abcde", "[^ce]")
str_view_all("abcde", "[^b]")

# range ou intervalo.
str_view_all("abcde", "[a-d]")
str_view_all("abcde", "[^a-d]")

# Âncoras: Começa com ^, termina com $.
str_view_all("aaa", "^a")
str_view_all("aaa", "a$")

# Look arounds.
# Seguido de...
str_view_all("bacad", "a(?c)")

# Não seguido de...
str_view_all("bacad", "a(?!c)")

# Precedido de...
str_view_all("bacad", "(?<=b)a")

# Não precedido de...
str_view_all("bacad", "(?<!b)a")

# Quantificadores.
# Nenhuma ou uma vez.
str_view_all(".a.aa.aaa", "a?")

# Nenhuma ou mais vezes.
str_view_all(".a.aa.aaa", "a*")

# Uma ou mais vezes.
str_view_all(".a.aa.aaa", "a+")

# Exatamente n vezes.
str_view_all(".a.aa.aaa", "a{2}")
str_view_all(".a.aa.aaa", "a{3}")


# n vezes ou mais.
str_view_all(".a.aa.aaa", "a{2,}")

# Entre n e m vezes.
str_view_all(".a.aa.aaa.aaaa.aaaaa", "a{2,4}")
str_view_all(".a.aa.aaa.aaaa.aaaaa", "a{1,3}")