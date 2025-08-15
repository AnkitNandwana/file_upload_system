# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Setup Instructions

Clone the repository

Run bundle install

Set up PostgreSQL database

Run migrations: rails db:create db:migrate

Install Redis for Sidekiq

Start services:

redis-server

bundle exec sidekiq

rails server

