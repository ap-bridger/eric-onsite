from typing import Optional, Any

import csv
import heapq

import editdistance
from pydantic import BaseModel



class Transaction(BaseModel):

    description: str
    spent: Optional[float] = None
    received: Optional[float] = None
    payee: Optional[str] = None
    category: Optional[str] = None

    # def __init__(self, description, spent=None, received=None, payee=None, category=None, **data: Any):
    #     super().__init__(**data)
    #     self.description: str = description
    #     self.spent: Optional[float] = spent
    #     self.received: Optional[float] = received
    #     self.payee: Optional[str] = payee
    #     self.category: Optional[str] = category


training_data: list[Transaction] = []
def load_training_data():
    print("Loading training data")
    train_data_tsv = "Bank Transactions - Register.tsv"

    # Open and read the TSV file
    with open(train_data_tsv, newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file, delimiter="\t")  # Set tab as the delimiter
        for row in reader:
            transaction = Transaction(
                description=row['Memo'],
                spent=float(row['Payment'].replace(",","")) if row['Payment'] and row['Payment'] != '' else None,
                received=float(row['Deposit'].replace(",","")) if row['Deposit'] and row['Deposit'] != '' else None,
                payee=row['Payee'] if row['Payee'] != '' else None,
                category=row['Account'] if row['Account'] != '' else None,
            )
            training_data.append(transaction)

def categorize(transaction: Transaction, top_n=5) -> tuple[list[str], list[str]] :

    payee_score: dict[str, float] = {}
    category_score: dict[str, float] = {}
    for train_transaction in training_data:
        dist = editdistance.distance(transaction.description, train_transaction.description)

        score = 1/dist

        if train_transaction.payee is not None:
            if train_transaction.payee not in payee_score:
                payee_score[train_transaction.payee] = 0
            payee_score[train_transaction.payee] += score
        if train_transaction.category is not None:
            if train_transaction.category not in category_score:
                category_score[train_transaction.category] = 0
            category_score[train_transaction.category] += score

    top_payee = heapq.nlargest(top_n, payee_score, key=payee_score.get)
    top_category = heapq.nlargest(top_n, category_score, key=category_score.get)

    return top_payee, top_category

