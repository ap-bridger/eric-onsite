## Overview

This service is set up with Langgraph and FastAPI.
Currently, there is only a single LLM call with no graphs or tools.

## Installation

`pip install -r requirements.txt`

## Add Environment

You can either run `export ANTHROPIC_API_KEY=...` to a `.env` file, or run it directly in a terminal

## Running the Server

`fastapi dev agent.py`

## Using the API

`curl http://localhost:8000/agent -H "Content-Type: application/json" -d '{"username": "1"}'`


[//]: # (curl http://localhost:8000/agent -H "Content-Type: application/json" -d '{"username": "1"}')


Invoke-RestMethod -Uri "http://localhost:8000/categorize" -Method Post -Headers @{ "Content-Type" = "application/json" } -Body '{"description": "Check 2158", "spent":210.00}'
