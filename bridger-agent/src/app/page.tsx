"use client";

import { apolloClient } from "@/client/graphql/apollo-client";
import { GreetButton } from "@/components/GreetButton/GreetButton";
import { ApolloProvider, useQuery } from "@apollo/client";
import { TRANSACTIONS } from "./api";

export default function Home() {
  return (
    <ApolloProvider client={apolloClient}>
      <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
        <main className="flex flex-col gap-8 row-start-2 items-center sm:items-start">
          <TransactionsView />
        </main>
      </div>
    </ApolloProvider>
  );
}

function TransactionsView() {
  const { data, error } = useQuery(TRANSACTIONS);
  if (error) {
    alert("ERROR:" + JSON.stringify(error));
  }
  if (!data) {
    return "loading...";
  }
  const rows = data.transactions.map((transaction: any) => {
    return (
      <tr key={transaction.id}>
        <td>
          {new Date(Number(transaction.transactionDatetime)).toDateString()}
        </td>
        <td>{transaction.bankDetail}</td>
      </tr>
    );
  });
  return (
    <div>
      <p>Transactions</p>
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>{rows}</tbody>
      </table>
    </div>
  );
}
