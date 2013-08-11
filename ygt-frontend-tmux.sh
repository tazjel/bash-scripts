#!/usr/bin/env bash

# Start a new session, of name 'main', with a window
# called 'frontend-server', and immediately detach.
tmux new-session -s main -n frontend-server -d

# Frontend server
tmux send-keys -t main 'cd ~/workspace/frontend' C-m
tmux send-keys -t main 'bundle exec rails server' C-m

# # Frontend console
# tmux new-window -t main -n frontend-console
# tmux send-keys -t main 'cd ~/workspace/frontend' C-m
# tmux send-keys -t main 'bundle exec rails console' C-m

# # Frontend terminal
# tmux new-window -t main -n frontend-terminal
# tmux send-keys -t main 'cd ~/workspace/frontend' C-m

# Searcher server
tmux new-window -t main -n searcher-server
tmux send-keys -t main 'cd ~/workspace/searcher' C-m
tmux send-keys -t main 'bundle exec rackup' C-m

tmux select-window -t main:1

tmux attach -t main
