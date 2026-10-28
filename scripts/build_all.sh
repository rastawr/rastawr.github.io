#!/bin/bash
# Build script for multi-site Jekyll setup
# Builds stable (to root), v1, and v2 sites

set -e  # Exit on error

echo "=== Building all Jekyll sites ==="

# Function to build a site
build_site() {
    local site_name=$1
    local site_dir="sites/$site_name"
    local dest_dir="_site/$site_name"

    # Special case: stable builds to root (_site/) not _site/stable/
    if [ "$site_name" = "stable" ]; then
        dest_dir="_site"
    fi

    echo "Building $site_name..."

    # Create destination directory
    mkdir -p "$dest_dir"

    # Build with Jekyll
    bundle exec jekyll build --source "$site_dir" --destination "$dest_dir" --config "$site_dir/_config.yml"

    echo "$site_name built successfully to $dest_dir"
}

# Build all sites
build_site "stable"
build_site "v1"
build_site "v2"

# Copy shared assets to _site root for GitHub Pages deployment
echo "Copying shared assets to _site root..."
mkdir -p _site/shared
cp -r shared/images _site/shared/
cp -r shared/content _site/shared/

echo "=== All sites built successfully! ==="
echo "Output structure:"
echo "  _site/         -> stable site deployed to root (username.github.io/)"
echo "  _site/v1/      -> deployed to /v1/"
echo "  _site/v2/      -> deployed to /v2/"
echo "  _site/shared/  -> shared assets at /shared/"