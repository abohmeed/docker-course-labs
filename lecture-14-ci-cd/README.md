# Lecture 14: Creating a CI/CD Docker pipeline

1. Fork https://github.com/docker/getting-started-app and point your clone at your fork (git remote set-url origin ...).
2. Copy .github/workflows/docker-image.yml from this folder into your fork.
3. Push to main: the workflow builds the image and pushes it to ghcr.io under your lower-cased repository name.

original-steps.md is the text that was attached to the lecture. The workflow here replaces the one in it (see the comment at the top of the file for what changed). It has not been run end to end yet.
