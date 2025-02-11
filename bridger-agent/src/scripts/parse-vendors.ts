import { prisma } from "@/lib/db";
import { parse } from "csv-parse/sync";
import { readFileSync } from "fs";

const run = async () => {
  console.log("Parsing file!");
  const data = readFileSync("/Users/alex/Downloads/test_vendors.csv", "utf-8");
  const rows = parse(data, { columns: true });

  for (const row of rows) {
    await prisma.payee.upsert({
      where: {
        id: row["Vendor"],
      },
      create: {
        id: row["Vendor"],
        name: row["Vendor"],
        quickBooksOnlineAccountId: 1,
      },
      update: {},
    });
  }
};

run();
