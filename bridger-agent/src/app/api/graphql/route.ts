import { greetings } from "@/server/modules/greet/api";
import { transactions } from "@/server/modules/transactions/api";
import { createSchema, createYoga } from "graphql-yoga";

const { handleRequest } = createYoga({
  schema: createSchema({
    typeDefs: /* GraphQL */ `
      type Transaction {
        id: String!
        quickBooksOnlineAccountId: String!
        transactionDatetime: String!
        bankDetail: String!
        categoryString: String
        payee: String
        spent: Float
        received: Float
      }
      type Query {
        greetings: String
        transactions: [Transaction!]!
      }
    `,
    resolvers: {
      Query: {
        greetings,
        transactions,
      },
    },
  }),

  // While using Next.js file convention for routing, we need to configure Yoga to use the correct endpoint
  graphqlEndpoint: "/api/graphql",

  // Yoga needs to know how to create a valid Next response
  fetchAPI: { Response },
});

export {
  handleRequest as GET,
  handleRequest as POST,
  handleRequest as OPTIONS,
};
