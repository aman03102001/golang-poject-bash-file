# /bin/bash!

# Multi stage build with go app: -Complete Step-by-Step Solution  Create the project structure:
mkdir go-docker-demo
cd go-docker-demo
# Initialize the Go module (this creates go.mod):
 go mod init example.com/go-docker-demo
#3. Create main.go with an external dependency (to force go.sum generation):
cat <<EOF > main.go
package main
import (
"fmt"
"net/http"
"github.com/gorilla/mux" // Adding external dependency
)
func main() {
r := mux.NewRouter()
r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
fmt.Fprintf(w, "Hello from Docker Multi-Stage Build!")
})
fmt.Println("Server starting on port 8080...")
http.ListenAndServe(":8080", r)
}
EOF

# This will download dependencies and create go.sum
go mod tidy
#5. Verify files exist:
ls -la
 
cat  <<EOF > Dockerfile


# Stage 1: Build the application
FROM golang:1.24.4-alpine AS builder
# Set working directory
WORKDIR /app
# Copy go mod and sum files
COPY go.mod go.sum ./
# Download all dependencies
RUN go mod download
# Copy the source code
COPY . .
# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main .
# Stage 2: Create minimal runtime image
FROM alpine:latest
WORKDIR /app
# Install CA certificates for HTTPS
RUN apk --no-cache add ca-certificates
# Copy only the built binary
COPY --from=builder /app/main /app/main
# Expose port
EXPOSE 8080
# Command to run
CMD ["/app/main"]

EOF
docker build -t go-docker-demo .
docker run -p 8080:8080 go-docker-demo
curl http://localhost:8080
