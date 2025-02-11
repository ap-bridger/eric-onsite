/*
  Warnings:

  - The primary key for the `Transaction` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Attachment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "transactionId" TEXT NOT NULL,
    "file" BLOB NOT NULL,
    CONSTRAINT "Attachment_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Attachment" ("file", "id", "transactionId") SELECT "file", "id", "transactionId" FROM "Attachment";
DROP TABLE "Attachment";
ALTER TABLE "new_Attachment" RENAME TO "Attachment";
CREATE TABLE "new_Transaction" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "quickBooksOnlineAccountId" INTEGER NOT NULL,
    "transactionDatetime" DATETIME NOT NULL,
    "bankDetail" TEXT NOT NULL,
    "categoryString" TEXT NOT NULL,
    "payee" TEXT NOT NULL,
    "spent" REAL NOT NULL,
    "received" REAL NOT NULL,
    "categorizedDate" DATETIME,
    "categoryId" INTEGER,
    "payeeId" INTEGER,
    CONSTRAINT "Transaction_quickBooksOnlineAccountId_fkey" FOREIGN KEY ("quickBooksOnlineAccountId") REFERENCES "QuickBooksOnlineAccount" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Transaction_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Transaction_payeeId_fkey" FOREIGN KEY ("payeeId") REFERENCES "Payee" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Transaction" ("bankDetail", "categorizedDate", "categoryId", "categoryString", "id", "payee", "payeeId", "quickBooksOnlineAccountId", "received", "spent", "transactionDatetime") SELECT "bankDetail", "categorizedDate", "categoryId", "categoryString", "id", "payee", "payeeId", "quickBooksOnlineAccountId", "received", "spent", "transactionDatetime" FROM "Transaction";
DROP TABLE "Transaction";
ALTER TABLE "new_Transaction" RENAME TO "Transaction";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
