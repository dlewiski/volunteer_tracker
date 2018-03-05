# Volunteer Tracker

#### A web application to help non-profit keep track of volunteers and projects

#### By David Lewis

## Setup/Installation Requirements

Clone to your Desktop.
In terminal, navigate to the root directory of the project. Be sure to install postgresql on your machine if not already.
Recreate the database by using the following commands in terminal:

```
$ bundle
```
```
$ psql
```
```
$ create database project;
```
```
$ \c project;
```
```
$ create table projects (id serial PRIMARY KEY, title varchar);
```
```
$ create table volunteers (id serial PRIMARY KEY, name varchar, project_id integer);
```
```
$ create database project_test with template project;
```
Use this command in terminal to run app on the localhost:

```
$ ruby app.rb
```

Open your browser and go to localhost:4567

## Specifications (use case scenarios)

* User can view, add, update and delete projects.
* User can view and add volunteers to projects.
* User can view volunteers on a projects

## Technologies Used

Ruby, Sinatra, Postgres, HTML, CSS, PSQL

## License

*Licensed under MIT license*

Copyright (c) 2018 **_David Lewis_**
