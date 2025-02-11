import { prisma } from "@/lib/db";
import { readFileSync } from "fs";

const run = async () => {
  console.log("Parsing file!");
  const data = readFileSync("/Users/alex/Downloads/test_bank_transactions.csv");
  console.log(data);
};

run();
