# 🚀 Go Docker Demo (Multi-Stage Build)

This project demonstrates a simple web server written in **Go** and containerized using a **multi-stage Docker build**. The server uses the `gorilla/mux` router and listens on **port 8080**.

---

## 📁 Project Structure

go-docker-demo/
├── main.go
├── go.mod
├── go.sum
└── Dockerfile

yaml
Copy
Edit

---

## 🛠️ Requirements

- Go (1.18+)
- Docker
- Git

---

## 🔧 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/go-docker-demo.git
cd go-docker-demo
2. Build and Run with Docker
bash
Copy
Edit
docker build -t go-docker-demo .
docker run -p 8080:8080 go-docker-demo
3. Test the Application
Open your browser or use curl:

bash
Copy
Edit
curl http://localhost:8080
Expected output:

csharp
Copy
Edit
Hello from Docker Multi-Stage Build!
🐳 Dockerfile (Multi-Stage)
Dockerfile
Copy
Edit
# Stage 1: Build the Go binary
FROM golang:1.24.4-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main .

# Stage 2: Create lightweight image
FROM alpine:latest
WORKDIR /app
RUN apk --no-cache add ca-certificates
COPY --from=builder /app/main /app/main
EXPOSE 8080
CMD ["/app/main"]
✍️ Author
Your Name
GitHub: @your-username

📄 License
This project is open source and available under the MIT License.

yaml
Copy
Edit

---

Let me know if you'd like me to generate:
- `.gitignore`
- `LICENSE`
- GitHub Actions CI workflow (`.github/workflows/docker.yml`)  
All optional but good for production-ready repos.
