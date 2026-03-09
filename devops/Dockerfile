# Use the official Python image from the Docker Hub, slim version for smaller size
FROM python:3.12-slim AS builder

ARG GITHUB_PAT

ENV PROJECT_ROOT="/app"

RUN pip install uv==0.6.14

# Set the working directory inside the container
WORKDIR ${PROJECT_ROOT}

# Copy the project's dependency files
COPY ./pyproject.toml pyproject.toml
COPY ./uv.lock uv.lock
COPY ./README.md README.md

# Install the project dependencies using UV
RUN --mount=type=cache,target=/root/.cache/uv \
    apt update && apt install -y git wget && apt clean && rm -rf /var/lib/apt/lists/* && \
    git config --global credential.helper store && \
    printf "https://__token__:${GITHUB_PAT}@github.com\n" > /root/.git-credentials && \
    chmod 600 /root/.git-credentials && \ 
    uv sync

# Copy the project source code into the container
FROM python:3.12-slim AS runtime


ENV PROJECT_ROOT="/app" 

ENV PATH="$PROJECT_ROOT/.venv/bin:$PATH"
ENV PYTHONPATH="$PROJECT_ROOT"
ENV VIRTUAL_ENV="$PROJECT_ROOT/.venv"

WORKDIR ${PROJECT_ROOT}

RUN apt update && \
    apt install -y ffmpeg curl iputils-ping wget net-tools && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY . ${PROJECT_ROOT}
COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

# Set the working directory to the service directory
WORKDIR ${PROJECT_ROOT}

# Define the command to run the application
CMD ["python","src/main.py"]
