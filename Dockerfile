#FROM python:3.12-slim
#RUN mkdir -p usr/src/app
#WORKDIR usr/src/app
#COPY . .
#RUN python -m pip install --upgrade pip
#RUN python -m pip install --upgrade setuptools==57.5.0 
#RUN python -m pip install wheel
#RUN pip install -r requirements.txt
#CMD ["gunicoirn","--bind","0.0.0.0:8000","ig_prj.wsgi:application"]





# Use an official Python runtime as a parent image
FROM python:3.10.12

# Set the working directory in the container
WORKDIR /usr/src/app


RUN apt-get update && apt-get install -y \
    gcc \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    libpq-dev


# Copy the requirements file into the container
COPY requirements.txt ./

# Install pip, setuptools, and wheel
RUN python -m pip install --upgrade pip setuptools wheel

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY . .


# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "ig_prj.wsgi:application"]

