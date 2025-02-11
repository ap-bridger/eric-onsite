-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Transaction" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "quickBooksOnlineAccountId" INTEGER NOT NULL,
    "transactionDatetime" DATETIME NOT NULL,
    "bankDetail" TEXT NOT NULL,
    "categoryString" TEXT NOT NULL,
    "payee" TEXT NOT NULL,
    "spent" REAL,
    "received" REAL,
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
