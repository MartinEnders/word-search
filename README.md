# word-search

word-search sucht basierend auf einer Wortliste [1] nach Woertern anhand der laenge und der enthaltenen Buchstaben wobei jeder Buchstabe nur einmal genutzt wird.

```cl
(word-search:find-word length word-pool)
```
Beim ersten aufruf von find-word wird, falls noch nicht geschehen, die Wortliste automatisch geladen.


Optional kann das laden der Wortliste durch init explizit angestossen werden.
```cl
(word-search:init :max-word-length nil)
```
:max-word-length (optional):
* Standard ist nil (alle Woerter werden geladen)
* Wenn eine Zahl (Pruefung auf integerp) angegeben wird werden nur Woerter bis zu der entsprechenden Laenge geladen. (Ich benoetige das fuer eine virtuelle Maschine die nicht genuegend Arbeitsspeicher hat.)



## Beispiel:

```cl
(word-search:find-word 4 "testbla")
```
=>
```cl
'("TEST" "TALS" "TABS" "STAB" "SEAT" "SATT" "LEST" "LEBT" "LEAS" "LAST" "LAST" "LABT" "LABE" "ETAT" "ELSA" "ELBA" "BETT" "BETA" "BELT" "BEAT" "BEAS" "BAST" "BASE" "ALTE" "ALBE" "ABEL")
```

Beim ersten Aufrum von word-search:find-word wird das Woerterbuch geladen. 
Das kann je nach Hardware eine gewisse Zeit in anspruch nehmen.




## Entwicklung:
Die Bibliothek wurde unter SBCL auf Debian GNU/Linux entwickelt und getestet.


## Quelle:
[1] http://sourceforge.net/projects/germandict/



## English
Based on the Wordlist from http://sourceforge.net/projects/germandict/

Find German words with determined length which can be build from a pool of Characters.
(each character can only be used once).

(word-search:find-word 3 'uknxdd') -> '("und" .... )