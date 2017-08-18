FROM python:2.7-alpine3.6

# Install AWS CLI, schedule package, and mongodb tools (for mongodump)
RUN pip install awscli schedule && \
	apk update && apk add mongodb-tools

# Add scripts
ADD app /app
RUN chmod +x /app/backup.sh

# Default environment variables
ENV BACKUP_INTERVAL 1
ENV BACKUP_TIME 2:00
ENV DATE_FORMAT %Y%m%d-%H%M%S
ENV FILE_PREFIX backup-

# Run the schedule command on startup
CMD ["python", "-u", "/app/run.py"]
