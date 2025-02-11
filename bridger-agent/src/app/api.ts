import { gql } from "@apollo/client";

export const TRANSACTIONS = gql(`
    query Transactions {
        transactions {
            id
            bankDetail
            spent
            received
            transactionDatetime
            categoryString
            payee
        }
    }`);
