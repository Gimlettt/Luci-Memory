from fastapi import FastAPI

from src.echo_api.router import echorouter

app = FastAPI()

app.include_router(echorouter, prefix="/echo", tags=["echo"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("src.main:app", host="0.0.0.0", port=8000)
