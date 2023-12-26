#!/bin/bash

# Error handling function
function handle_error {
  echo "Error: $1" >&2
  exit 1
}

# Check if a project name is provided
if [ -z "$1" ]; then
    handle_error "Usage: $0 <project-name> [path]"
fi

# Set project name
project_name="$1"

# Set project path, default to current directory if not provided
project_path="${2:-.}"

# Check if the project directory already exists
if [ -e "$project_path/$project_name" ]; then
    handle_error "Directory '$project_path/$project_name' already exists. Please choose a different project name or path."
fi

# Create project directory
mkdir -p "$project_path/$project_name" || handle_error "Failed to create project directory."

# Navigate to the project directory
cd "$project_path/$project_name" || handle_error "Failed to navigate to project directory."

# Initialize npm and install TypeScript
npm init -y || handle_error "Failed to initialize npm."
npm install typescript --save-dev || handle_error "Failed to install TypeScript."

# Install Node.js ambient types for TypeScript
npm install @types/node --save-dev || handle_error "Failed to install Node.js ambient types."

# Create 'tsconfig.json'
npx tsc --init --rootDir src --outDir build \
--esModuleInterop --resolveJsonModule --lib es6 \
--module commonjs --allowJs true --noImplicitAny true || handle_error "Failed to create 'tsconfig.json'."

# Create 'src' directory and 'index.ts' inside it
mkdir src || handle_error "Failed to create 'src' directory."
touch src/index.ts || handle_error "Failed to create 'index.ts' file."

# Install tools for cold reloading using nodemon
npm install --save-dev ts-node nodemon || handle_error "Failed to install ts-node and nodemon."

# Create 'nodemon.json' in the root directory
echo '{
  "watch": ["src"],
  "ext": ".ts,.js",
  "ignore": [],
  "exec": "npx ts-node ./src/index.ts"
}' > nodemon.json || handle_error "Failed to create 'nodemon.json'."

# Add scripts to package.json for running in development and production modes
echo '{
  "scripts": {
    "start:dev": "npx nodemon",
    "start": "npm run build && node build/index.js",
    "build": "rimraf ./build && tsc"
  }
}' > package.json || handle_error "Failed to update 'package.json' with scripts."

# Install rimraf for directory obliteration
npm install --save-dev rimraf || handle_error "Failed to install rimraf."

echo "Project '$project_name' created successfully in '$project_path/$project_name'."
echo "Navigate to '$project_path/$project_name' and run 'npm run start:dev' to start development with nodemon."
echo "For production builds, run 'npm run build' and 'npm start'."

