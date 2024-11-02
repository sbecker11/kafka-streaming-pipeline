# Use an official Python runtime as a parent image
FROM python:3.9-slim as builder

# Set the working directory in the container
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install .

# After installing packages to reduce the image size.
RUN apt-get clean 

# Create a user to run the application
RUN adduser -S appuser && chown -R appuser: /app
USER appuser

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Add a healthcheck to ensure your service is responsive in production.
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s CMD curl -f http://localhost:8080/health || exit 1

# Run the application
CMD ["python", "src/transformer.py"]