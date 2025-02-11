import { prisma } from "@/lib/db";
import { parse } from "csv-parse/sync";
import { readFileSync } from "fs";

function parseDollarStringToNumber(dollarString: string): number {
  // Remove the dollar sign and any commas
  const sanitizedString = dollarString.replace(/[$,]/g, "");

  // Convert the sanitized string to a number
  return parseFloat(sanitizedString);
}

const run = async () => {
  console.log("Parsing file!");
  const data = readFileSync(
    "/Users/alex/Downloads/test_transactions_2.csv",
    "utf-8"
  );
  const rows = parse(data, { columns: true });
  const client = await prisma.client.upsert({
    where: {
      id: 1,
    },
    create: {
      id: 1,
    },
    update: {},
  });
  const qboAccount = await prisma.quickBooksOnlineAccount.upsert({
    where: {
      id: 1,
    },
    create: {
      id: 1,
      clientId: 1,
    },
    update: {},
  });
  for (const row of rows) {
    const id =
      row["Date"] + row["SPENT"] + row["RECEIVED"] + row["DESCRIPTION"];
    console.log("DATE:", row["TransactionDate"], "ROW:", row);
    const upsertData = {
      id,
      quickBooksOnlineAccountId: 1,
      transactionDatetime: new Date(row["TransactionDate"]),
      bankDetail: row["DESCRIPTION"],
      categoryString: row["Categorize or match"],
      payee: row["Payee"],
      spent: row["SPENT"] ? parseDollarStringToNumber(row["SPENT"]) : null,
      received: row["RECEIVED"]
        ? parseDollarStringToNumber(row["RECEIVED"])
        : null,
    };
    await prisma.transaction.upsert({
      where: {
        id,
      },
      create: upsertData,
      update: upsertData,
    });
  }
};

run();
