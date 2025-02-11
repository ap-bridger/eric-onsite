-- CreateTable
CREATE TABLE "Client" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "QuickBooksOnlineAccount" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "clientId" INTEGER NOT NULL,
    CONSTRAINT "QuickBooksOnlineAccount_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
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

-- CreateTable
CREATE TABLE "Attachment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "transactionId" INTEGER NOT NULL,
    "file" BLOB NOT NULL,
    CONSTRAINT "Attachment_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Category" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "quickBooksOnlineAccountId" INTEGER NOT NULL,
    CONSTRAINT "Category_quickBooksOnlineAccountId_fkey" FOREIGN KEY ("quickBooksOnlineAccountId") REFERENCES "QuickBooksOnlineAccount" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Payee" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "quickBooksOnlineAccountId" INTEGER NOT NULL,
    CONSTRAINT "Payee_quickBooksOnlineAccountId_fkey" FOREIGN KEY ("quickBooksOnlineAccountId") REFERENCES "QuickBooksOnlineAccount" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
