#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <project-name>"
    exit 1
fi

PROJECT_NAME="$1"

if [ -e "$PROJECT_NAME" ]; then
    echo "Error: '$PROJECT_NAME' already exists."
    exit 1
fi

mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

echo "Creating Express project: $PROJECT_NAME"

npm init -y >/dev/null
npm install express dotenv
npm install --save-dev nodemon

mkdir -p \
    src/config \
    src/controllers \
    src/middleware \
    src/routes \
    src/services

touch \
    src/config/db.js \
    src/controllers/.gitkeep \
    src/routes/.gitkeep \
    src/services/.gitkeep

cat > index.js <<'EOF'
require('dotenv').config();

const app = require('./src/app');

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
EOF

cat > src/app.js <<'EOF'
const express = require('express');

const logger = require('./middleware/logger');
const notFound = require('./middleware/notFound');
const errorHandler = require('./middleware/errorHandler');

const app = express();

app.use(express.json());
app.use(logger);

app.get('/', (req, res) => {
    res.json({
        message: 'API is running'
    });
});

/*
Example:

const usersRouter = require('./routes/users.routes');
app.use('/users', usersRouter);
*/

app.use(notFound);
app.use(errorHandler);

module.exports = app;
EOF

cat > src/middleware/logger.js <<'EOF'
function logger(req, res, next) {
    console.log(`${req.method} ${req.originalUrl}`);
    next();
}

module.exports = logger;
EOF

cat > src/middleware/notFound.js <<'EOF'
function notFound(req, res) {
    res.status(404).json({
        error: 'Route not found'
    });
}

module.exports = notFound;
EOF

cat > src/middleware/errorHandler.js <<'EOF'
function errorHandler(err, req, res, next) {
    console.error(err);

    if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
        return res.status(400).json({
            error: 'Invalid JSON body'
        });
    }

    res.status(500).json({
        error: 'Internal server error'
    });
}

module.exports = errorHandler;
EOF

cat > src/middleware/asyncHandler.js <<'EOF'
function asyncHandler(handler) {
    return function wrappedHandler(req, res, next) {
        Promise.resolve(handler(req, res, next)).catch(next);
    };
}

module.exports = asyncHandler;
EOF

cat > .env <<'EOF'
PORT=3000
EOF

cat > .env.example <<'EOF'
PORT=3000
EOF

cat > .gitignore <<'EOF'
node_modules/
.env
EOF

cat > README.md <<EOF
# $PROJECT_NAME

A Node.js and Express API.

## Installation

\`\`\`bash
npm install
\`\`\`

Create your local environment file:

\`\`\`bash
cp .env.example .env
\`\`\`

## Run in development

\`\`\`bash
npm run dev
\`\`\`

## Run normally

\`\`\`bash
npm start
\`\`\`
EOF

node -e "
const fs = require('fs');

const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));

packageJson.scripts = {
    start: 'node index.js',
    dev: 'nodemon index.js'
};

fs.writeFileSync(
    'package.json',
    JSON.stringify(packageJson, null, 2) + '\n'
);
"

git init >/dev/null

echo
echo "Project created successfully."
echo
echo "Next commands:"
echo "  cd $PROJECT_NAME"
echo "  npm run dev"
