# README

## Overview

Repo for database sandbox for exploring schema and relationship configs prior to implementing in Prod version

## Prequisites

- Ruby 2.6.3
- Rails 6.0

## Installation

###### 1. Clone repo into your local environment:

Run:

```Bash
git clone <repo name>
```

Then navigate into the cloned repo

```Bash
cd <directory_name>
```
###### 2. Install dependencies

```Bash
bundle install && bundle update
```

###### 3. Set up local version of Database

- Create database:
```Bash
rails db:create
```

- Migrate schema:
```Bash
rails db:migrate
```

- Seed database:
```Bash
rails db:seed
```

## Running the Database

###### __Starting the server__:
```Bash
rails s
```

###### __Stopping the server__:

Key command: `Ctrl` + `c`



## Architecture Overview

The database consists of 3 tables:
- `Album`
- `Song`
- `Version`

An
