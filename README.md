# Create Express Project

A Bash script that bootstraps a Node.js and Express API with a clean, reusable project structure.

It creates the base files and middleware needed to start building backend projects quickly, without repeating the same setup every time.

## Features

* Initializes a new Node.js project
* Installs Express and dotenv
* Installs nodemon for development
* Creates a structured Express project layout
* Adds common middleware:

  * Request logger
  * 404 handler
  * Central error handler
  * Async route handler
* Creates `.env`, `.env.example`, and `.gitignore`
* Adds `npm start` and `npm run dev` scripts
* Initializes a Git repository

## Requirements

* Node.js
* npm
* Bash
* Git

## Installation

Clone this repository:

```bash
git clone <your-repository-url>
cd create-express-project
```

Make the script executable:

```bash
chmod +x create-express-project.sh
```

## Usage

Run the script with your desired project name:

```bash
./create-express-project.sh my-api
```

Example:

```bash
./create-express-project.sh todo-list-api
```

Then enter the created project:

```bash
cd todo-list-api
npm run dev
```

The API will start at:

```txt
http://localhost:3000
```

## Generated Structure

```txt
my-api/
├── index.js
├── src/
│   ├── app.js
│   ├── config/
│   │   └── db.js
│   ├── controllers/
│   ├── middleware/
│   │   ├── asyncHandler.js
│   │   ├── errorHandler.js
│   │   ├── logger.js
│   │   └── notFound.js
│   ├── routes/
│   └── services/
├── .env
├── .env.example
├── .gitignore
├── README.md
└── package.json
```

## Included Scripts

```bash
npm start
```

Runs the application normally:

```bash
node index.js
```

```bash
npm run dev
```

Runs the application with nodemon, which restarts the server automatically when files change.

## Adding a Database

For PostgreSQL projects, install the required driver:

```bash
npm install pg
```

Then add database variables to `.env`:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=your_database_name
DB_USER=your_database_user
DB_PASSWORD=your_database_password
```

Do not commit `.env`. Use `.env.example` as the safe template for required environment variables.

## Link the local repository to GitHub

Replace `YOUR_USERNAME` with your GitHub username:

```bash
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/create-express-project.git
git push -u origin main
```

Example:

```bash
git remote add origin https://github.com/Oussama-ay/create-express-project.git
git push -u origin main
```
