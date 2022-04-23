# Llama's Magazine - API

Go forth and conquer!

###Environment
* Ruby : 2.7.2
* Rails : 6.1.5
* Using Heroku as infrastructure
* Using AWS S3 as static assets storage service

###API Document
```text
The URL
```

---
###Snippets may you need

####Seed
on your local
```shell
$ rails db:seed
```

on production
```shell
$ heroku run db:seed
```

####Destroy everything and replant [DANGER]
```shell
$ heroku restart 
$ heroku pg:reset DATABASE --confirm llama-magazine-api
$ heroku run rails db:migrate
$ heroku run rails db:seed
```


###Deploy
```shell
$ git push heroku main
```  

###Connect to instance
shell
```shell
$ heroku run bash
```
rails console
```shell
$ heroku console
```