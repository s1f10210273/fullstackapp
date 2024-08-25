# 定義
.PHONY: install dev build start backend frontend clean down lint docker-clean create-venv setup docker-build

# 依存関係のインストール
install: create-venv
	@echo "Installing dependencies..."
	cd frontend && pnpm install
	cd backend && \
	source env/bin/activate && \
	pip install -r requirements.txt

# 仮想環境の作成
create-venv:
	@echo "Creating virtual environment..."
	cd backend && python -m venv env

# 開発サーバーの起動（フロントエンドとバックエンド）
dev: frontend backend
	@echo "Starting development servers..."

frontend:
	@echo "Starting frontend development server..."
	cd frontend && pnpm dev

backend:
	@echo "Starting backend development server..."
	cd backend && \
	source env/bin/activate && \
	python manage.py runserver

# フロントエンドのビルド
build-frontend:
	@echo "Building frontend..."
	cd frontend && pnpm build

# バックエンドのマイグレーション & サーバー起動
start-backend:
	@echo "Applying migrations and starting backend..."
	cd backend && \
	source env/bin/activate && \
	python manage.py makemigrations && \
	python manage.py migrate && \
	python manage.py runserver

# バックエンドのテスト
test-backend:
	@echo "Running backend tests..."
	cd backend && \
	source env/bin/activate && \
	python manage.py test

# Docker Composeを使って起動
up:
	@echo "Building and starting Docker containers..."
	docker-compose up --build

# Docker Composeを使って停止
down:
	@echo "Stopping Docker containers..."
	docker-compose down

# Dockerのビルド
docker-build:
	@echo "Building Docker images..."
	docker-compose build

# クリーンアップ
clean:
	@echo "Cleaning up..."
	rm -rf frontend/node_modules
	rm -rf backend/__pycache__
	rm -rf backend/db.sqlite3

# Dockerイメージとコンテナの削除
docker-clean:
	@echo "Removing all Docker images and containers..."
	docker-compose down --rmi all --volumes --remove-orphans

# フロントエンドの lint チェック
lint:
	@echo "Running frontend lint..."
	cd frontend && pnpm lint

# フロントエンドの prettier チェック
prettier:
	@echo "Running frontend prettier..."
	cd frontend && pnpm prettier --check .

# 環境構築全体
setup: create-venv install docker-build
	@echo "Environment setup complete."
