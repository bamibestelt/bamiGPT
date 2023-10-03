# Use an official Python runtime as the base image
FROM python:latest

# Set the working directory inside the container
WORKDIR /app

# Copy main.py and ingest.py from the current directory into the container
COPY constants.py /app/
COPY ingest.py /app/
COPY privateGPT.py /app/
#COPY .venv/ /app/.venv/
COPY .env_docker /app/.env
#COPY models/ /app/models/
#COPY source_documents /app/source_documents/

# Copy the requirements.txt file into the container at /app
#RUN . /app/.venv/bin/activate
#COPY requirements.txt /app/
#RUN pip3 install -r requirements.txt
RUN pip install --upgrade pip
RUN pip install sentence_transformers gpt4all langchain chromadb tqdm unstructured
# Download and add pandoc to the PATH
RUN pip install pypandoc && \
    python3 -c "from pypandoc.pandoc_download import download_pandoc; download_pandoc()"

ENV PATH="/root/.pandoc:${PATH}"

ENTRYPOINT [ "tail", "-f", "/dev/null" ]