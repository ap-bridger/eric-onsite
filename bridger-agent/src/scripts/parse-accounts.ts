import { prisma } from "@/lib/db";
import { parse } from "csv-parse/sync";
import { readFileSync } from "fs";

const run = async () => {
  console.log("Parsing file!");
  const data = readFileSync("/Users/alex/Downloads/test_accounts.csv", "utf-8");
  const rows = parse(data, { columns: true });

  for (const row of rows) {
    await prisma.category.upsert({
      where: {
        id: row["Account"],
      },
      create: {
        id: row["Account"],
        name: row["Account"],
        quickBooksOnlineAccountId: 1,
      },
      update: {},
    });
  }
};

run();
