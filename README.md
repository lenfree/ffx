# Ffx

- [Ffx](#ffx)
  - [Overview](#overview)
  - [Prequisite](#prequisite)
    - [For docker-machine user](#for-docker-machine-user)
    - [Start ArangoDB docker container](#start-arangodb-docker-container)
    - [Setup dev and test database](#setup-dev-and-test-database)
    - [Setup full text search](#setup-full-text-search)
  - [Start your Phoenix server](#start-your-phoenix-server)
    - [Insert an article:](#insert-an-article)
    - [Get article](#get-article)
    - [Search article summary by tag and date](#search-article-summary-by-tag-and-date)
  - [TODO](#todo)
  - [Learn more](#learn-more)

## Overview

Ffx is a RESTful app that allows user to create article, retrive by article ID and
by tag and date created. This uses ArangoDB as its backend search engine. Why ArangoDB?
This is new to me and it would be a good opportunity for me to learn as well as Elixir
and Phoenix framework.

_NOTE_ This is only for demo purposes.

An article looks like this:

```json
{
  "id": 1,
  "title": "latest science shows that potato chips are better for you than sugar",
  "date" : "2016-09-22",
  "body" : "some text, potentially containing simple markup about how potato chips are great",
  "tags" : ["health", "fitness", "science"]
}
```

A tag and date search result looks like this:

```json
{
  "tag" : "health",
  "count" : 17,
    "articles" :
      [
        "1",
        "7"
      ],
    "related_tags" :
      [
        "science",
        "fitness"
      ]
}
```

## Prequisite

Docker, I use `docker-machine`, please refer to [install](https://docs.docker.com/install/) if you need one.

### For docker-machine user

```bash
docker-machine create v1
docker-machine start v1
eval $(docker-machine env v1)
```

**NOTE** If you use docker for mac or on Linux, please update line 51 of `config/dev.exs` and line 13 of `config/test.exs` to point to your
ArangoDB instance IP/hostname.

### Start ArangoDB docker container

```bash
docker run --net host --env ARANGO_NO_AUTH=1 --publish 8529:8529 --env ARANGO_NO_AUTH=1 arangodb/arangodb
```

### Setup dev and test database

Please add `ffx` with `root` username, might as well add `ffx_test` for test environment.

![Alt text](./assets/createdb.png?raw=true "add database")
![Alt text](./assets/createdb&#32;name&#32;and&#32;username.png?raw=true "create database and username")

### Setup full text search

There's a race condition when creating an index search from UI where collection does not exists yet. To make this work, please [start](#start-your-phoenix-server)
and [insert article](#insert-an-article) first before [query tag](#search-article-summary-by-tag-and-date)

Please select `ffx_posts` collection to setup fulltext index search.

![Alt text](./assets/select&#32;db.png?raw=true "select database")
![Alt text](./assets/click&#32;collection.png?raw=true "collection")
![Alt text](./assets/select&#32;full&#32;text&#32;index.png?raw=true "select database")
![Alt text](./assets/configure&#32;fulltext&#32;search.png?raw=true "select database")

*NOTE* Above container is only for development and not advisable for production use. 

## Start your Phoenix server

- Install dependencies with `mix deps.get`
- Start Phoenix endpoint with `MIX_ENV=dev mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Insert an article:

```bash
$ curl -XPOST -d '{ "date": "2020-03-04", "title": "whatever", "body": "whatever hello body", "tags": ["sports", "general"] }' -H 'Content-type: application/json' localhost:4000/articles

{
  "data": {
    "date": "20200304",
    "id": "ffx_posts/27809",
    "tags": [
      "sports",
      "general"
    ],
    "text": "whatever hello body",
    "title": "whatever"
  }
}
```

### Get article

```bash
$ curl localhost:4000/articles/28024

{
  "data": {
    "date": "2020-03-04",
    "id": "28024",
    "tags": [
      "sports",
      "general"
    ],
    "text": "whatever hello body",
    "title": "whatever"
  }
}
```

### Search article summary by tag and date

```bash
$ curl localhost:4000/tags/media/20200304| jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    81  100    81    0     0   3857      0 --:--:-- --:--:-- --:--:--  4050
{
  "articles": [
    "27442",
    "27783"
  ],
  "count": 2,
  "related_tags": [
    "general"
  ],
  "tag": "media"
}
```

## TODO

Increase test coverage
Flesh out API spec

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
- ArangoDB: https://www.arangodb.com/docs/stable/drivers/go-getting-started.html
- Xarango: https://github.com/beno/xarango