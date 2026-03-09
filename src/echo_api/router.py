from fastapi import APIRouter

from src.echo_api.schemas import EchoRequest, EchoResponse
from src.echo_api.service import echo_message

echorouter = APIRouter()


@echorouter.get("/health")
def health() -> dict[str,str]:
    return {"status": "ok"}


@echorouter.post("/", response_model=EchoResponse)
def echo(req: EchoRequest) ->EchoResponse:
    message = echo_message(req.message)
    return EchoResponse(message=message)
