#!/bin/bash
source backend/venv/bin/activate
cd backend
uvicorn app:app --reload
