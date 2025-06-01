#!/usr/bin/env bash

# Auto-discover project directories
PROJECT_ROOT="$HOME/Repositories"
PROJECTS=($(find "$PROJECT_ROOT" -mindepth 1 -maxdepth 1 -type d | sort))

# Ensure tmux server is running
tmux start-server

# Prompt user to select a project
selected_project=$(printf "%s\n" "${PROJECTS[@]}" | fzf)

# Exit if no project is selected
[ -z "$selected_project" ] && exit 1

# Extract project name for session name
session_name=$(basename "$selected_project")

# If session exists, attach to it
if tmux has-session -t "$session_name" 2>/dev/null; then
  tmux attach-session -t "$session_name"
  exit 0
fi

# Create a new tmux session and name it after the project
tmux new-session -d -s "$session_name" -c "$selected_project"

# Set up Neovim in the first window (Window 0)
tmux rename-window -t "$session_name:0" "nvim"
tmux send-keys -t "$session_name:0" "nvim ." C-m

# Create a second window (Window 1) for npm run dev
tmux new-window -t "$session_name:1" -c "$selected_project" -n "dev"

# Create a third window (Window 2) for git operations
tmux new-window -t "$session_name:2" -c "$selected_project" -n "git"
tmux send-keys -t "$session_name:2" "git status" C-m

# Attach to the tmux session
tmux attach-session -t "$session_name"
