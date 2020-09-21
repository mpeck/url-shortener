# URL Shortener

A simple URL shortener in elixir.

## Installation

This project was built with elixir 1.10.4 and erlang/OTP 23.0.4.

For instructions on installing elixir see [elixir-lang.org](https://elixir-lang.org/install.html).

Once elixir and erlang are both installed just run `make setup` to install dependancies and setup the db schema. Note: mnesia was used for persistance so you won't need any external database applications running.

## Project Structure

The project is broken into three different sections:
* shorturl - Contains the main internal API for the application.
* db - Contains the persistence layer for the application.
* Web - Provides the external interface to the application.

This allows us to swap out pieces as necessary. If for example it's decided that we should use PostgreSQL instead of mnesia we can just swap out the db piece with a PostgreSQL client. As long as the client implements the `Store` protocol it should just work.

## Testing

Run `make test` at the top level to run all tests or in individual app directories to run tests specific to that app.

## Starting the service

Run `make server` in the root or in the app/web directory to start the service up.
