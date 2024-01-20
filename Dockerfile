FROM public.ecr.aws/p5j3z0i6/mongo:latest

# Copy the script from the local machine to the Docker image
COPY ./script.sh /usr/local/bin/script.sh

# Give execute permissions to the script
RUN chmod +x /usr/local/bin/script.sh