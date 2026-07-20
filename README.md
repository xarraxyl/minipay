# minipay - a demo payment app

## Database initialization

`rails db:create`

## CSV import

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

## Payment API

send a valid POST request to /payments

the body must be a valid json containing: `merchant_id`, `amount`, `customer_email`, `status` and `type`.

Don't forget to submit a valid authentication token in the header.

```
curl -X POST localhost:3000/payments \
  -H "Authorization: Bearer eyJfcmFpbHMiOnsiZGF0YSI6MSwicHVyIjoidXNlciJ9fQ--63e682992970dda86b064fbff953bd92aca8399af6ddc6989dbf72ba96440c87" \
  -H "Content-Type: application/json" \
  -d '{ "amount": 2000, "customer_email": "hi@lala.com", "status": "approved", "merchant_id": 1 }' 
```

## How to run the test suite

- ingration tests: `rspec`

## Services (job queues, cache servers, search engines, etc.)

## Deployment instructions

