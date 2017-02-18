install.packages("rJava")
install.packages("NLP")
install.packages("openNLP")
library(rJava)
library(NLP)
library(openNLP)

require("NLP")
## Some text.
s <- paste(c("Pierre Vinken, 61 years old, will join the board as a ",
             "nonexecutive director Nov. 29.\n",
             "Mr. Vinken is chairman of Elsevier N.V., ",
             "the Dutch publishing group."),collapse = "")
s <- as.String(s)

## Chunking needs word token annotations with POS tags.
sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()
a2<-annotate(s,list(sent_token_annotator,word_token_annotator))
pos_tag_annotator <- Maxent_POS_Tag_Annotator()
a3 <- annotate(s,pos_tag_annotator,a2)
a3w<-subset(a3,type=="word")
tags<-sapply(a3w$features,"[[","POS")
tags
table(tags)
#extract token POS together.
sprintf("%s/%s",s[a3w],tags)

#Part2 Demo of openNLP: NER Named Entity Recognition/ Entity extraction, Visualize output
install.packages("magrittr")
library(magrittr)

text<-readLines("Amazon reviews.txt")
text<-paste(text,collapse=" ")
text<-as.String(text)
sent_ann <- Maxent_Sent_Token_Annotator()
word_ann <- Maxent_Word_Token_Annotator()
pos_ann <- Maxent_POS_Tag_Annotator()

pos_annotations<-annotate(text,list(sent_ann,word_ann,pos_ann))
text_annotations<-annotate(text,list(sent_ann,word_ann))
head(text_annotations)
text_doc<-AnnotatedPlainTextDocument(text,text_annotations)
words(text_doc) %>% head(10)

install.packages("openNLPmodels.en", repos ="http://datacube.wu.ac.at/", type = "source")
library(openNLPmodels.en)
person_ann<-Maxent_Entity_Annotator(kind="person")
location_ann<-Maxent_Entity_Annotator(kind="location")
organization_ann<-Maxent_Entity_Annotator(kind="organization")
date_ann<-Maxent_Entity_Annotator(kind="date")

pipeline<-list(sent_ann,word_ann,person_ann,location_ann,organization_ann,date_ann)
text_annotations<-annotate(text,pipeline)
text_doc<-AnnotatedPlainTextDocument(text,text_annotations)

entities<- function(doc,kind){
  s = doc$content
  a<-annotations(doc)[[1]]
  if(hasArg(kind)){
    k<-sapply(a$features,'[[',"kind")
    s[a[k==kind]]
  } else{
    s[a[a$type=="entity"]]
    
  }
  }

entities(text_doc,kind="person")
entities(text_doc,kind="location")
entities(text_doc,kind="organization")
entities(text_doc,kind="date")









person(text_doc) %>% head(10)





