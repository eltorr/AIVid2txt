@echo off
call backend\venv\Scripts\activate.bat
cd backend
uvicorn app:app --reload 