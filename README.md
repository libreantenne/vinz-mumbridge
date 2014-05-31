# Mumbride #

Bot faisant le pont entre IRC et Mumble (messages textes)

# Installation #

Dépendances :

* Ruby (ici 2.1)
* Bundler (`gem install bundler`)

Installation :  
`bundle install` (Assurez-vous d’avoir `bundle` dans votre PATH)

Lancement :  
`ruby app.rb`

# Configuration

La configuration se fait dans `app.rb` à l’aide des variables `@server`, `@port`, `@nick`, `@channel` et `@verbose` concernant IRC.

Pour le mumble, il faut modifier la ligne 19.

# Autre chose ?

Ouais, c’est fait un peu cradement.