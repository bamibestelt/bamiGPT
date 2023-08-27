# Use an official Python runtime as the base image
FROM python:latest

# Set the working directory inside the container
WORKDIR /app

# Copy main.py and ingest.py from the current directory into the container
COPY constants.py /app/
COPY ingest.py /app/
COPY privateGPT.py /app/

# Copy the requirements.txt file into the container at /app
COPY requirements.txt /app/

RUN python3 -V
RUN pip3 -V

RUN pip3 install --upgrade pip

# Install Python modules specified in requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Install sentence_transformers
RUN pip3 install sentence_transformers

# Download and add pandoc to the PATH
RUN pip3 install pypandoc && \
    python -c "from pypandoc.pandoc_download import download_pandoc; download_pandoc()"

ENV PATH="/root/.pandoc:${PATH}"

RUN pip3 list

# Run ingest.py
RUN python3 ingest.py

# Run main.py after ingest.py is executed
CMD ["python3", "main.py"]
