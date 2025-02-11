import { prisma } from "@/lib/db";

export const transactions = async () => {
  const transactions = await prisma.transaction.findMany();
  return transactions;
};
