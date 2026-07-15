# README

## Ruby version

## System dependencies

## Configuration

## Database creation

## Database initialization

`rails db:create`

To seed the data with users, you can use the `rake import:users` task. Simply pass a FILE=/path/to/csv to import from that file.

Your csv file must be in the following format:

- role: "admin" or "user"
- email: valid email
- password: in plaintext (I am assuming this is not production data.) and surrounded by double quotes `"` in order to guard against the passwords containing commas.

if "merchant" is under role the rows must also contain:

- name (surrounded by double quotes to guard against "John, Jr.")
- description (surrounded by double quotes to guard against commans)
- email
- status
- total_transaction_sum

* How to run the test suite

- ingration tests: `rspec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
