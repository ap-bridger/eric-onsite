# client
1. id

# quick_books_online_account
1. id
2. client_id


## Transaction
0. id
1. quick_books_online_account_id
2. transaction_datetime
3. bank_detail
4. payee
6. spent
7. received
8. categorized_date
5. category_id
9. payee_id


## attachments
1. id
2. transaction_id
3. file (blob)

## category
1. id
2. name
3. quick_books_online_account_id

## payee
1. id
2. name
3. quick_books_online_account_id
