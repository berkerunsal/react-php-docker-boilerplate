#!/bin/bash

# Build the project
npm run build

# Move index.html from dist to app
mv app/dist/index.html app/

REMOTE_USER="username@domain.com"
REMOTE_HOST="host"
REMOTE_PORT="21" # Default FTP port
REMOTE_PATH="/" # Path on the FTP server
PASSWORD="password"

# Upload the build files to the remote server using lftp
lftp -u $REMOTE_USER,$PASSWORD -p $REMOTE_PORT $REMOTE_HOST <<EOF
set ftp:ssl-allow no
cd $REMOTE_PATH
# Remove all files and directories in the remote path in batches of 10
cls -1 | xargs -d '\n' -n 10 rm -r
# Upload new files
mirror -R --verbose app/ ./
quit
EOF

echo "Deployment completed successfully!"
