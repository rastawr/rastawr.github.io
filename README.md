# Nickhil Niranjan's Portfolio - Multi-Version Jekyll Site

A Jekyll-based portfolio website with support for multiple versions (stable, v1, v2) deployed to GitHub Pages.

## Structure

```
├── .github/workflows/deploy.yml    # GitHub Actions deployment workflow
├── sites/
│   ├── stable/                     # Current stable version (served at root)
│   ├── v1/                         # Version 1 (served at /v1/)
│   └── v2/                         # Version 2 (served at /v2/)
├── shared/
│   ├── images/                     # Shared images across all versions
│   └── content/                    # Shared content (resume.pdf, etc.)
├── scripts/
│   └── build_all.sh                # Build script for all versions
├── Gemfile                         # Ruby dependencies
├── Gemfile.lock
└── .gitignore
```

## Local Development

### Prerequisites
- Ruby 3.3+
- Bundler (`gem install bundler`)

### Setup
```bash
bundle install
```

### Build All Sites
```bash
./scripts/build_all.sh
```

Output will be in `_site/`:
- `_site/stable/` - Stable version (deployed to root)
- `_site/v1/` - Version 1 (deployed to `/v1/`)
- `_site/v2/` - Version 2 (deployed to `/v2/`)
- `_site/shared/` - Shared assets

### Serve a Specific Version Locally
```bash
# Serve stable (at http://localhost:4000)
bundle exec jekyll serve --source sites/stable --config sites/stable/_config.yml

# Serve v1 (at http://localhost:4000/v1)
bundle exec jekyll serve --source sites/v1 --config sites/v1/_config.yml --baseurl /v1

# Serve v2 (at http://localhost:4000/v2)
bundle exec jekyll serve --source sites/v2 --config sites/v2/_config.yml --baseurl /v2
```

## Deployment

The site is automatically deployed to GitHub Pages on push to `main` branch via GitHub Actions (`.github/workflows/deploy.yml`).

### Deployment URLs
- **Stable**: `https://rastawr.github.io/`
- **v1**: `https://rastawr.github.io/v1/`
- **v2**: `https://rastawr.github.io/v2/`

### How It Works
1. GitHub Actions runs `scripts/build_all.sh` which builds all three Jekyll sites
2. Each site is built to its own subdirectory in `_site/`
3. Shared assets are copied to `_site/shared/`
4. The entire `_site/` directory is deployed to GitHub Pages
5. GitHub Pages serves:
   - `stable/` at the root domain
   - `v1/` at `/v1/`
   - `v2/` at `/v2/`
   - `shared/` at `/shared/`

## Adding a New Version

1. Copy `sites/stable/` to `sites/v3/`
2. Update `sites/v3/_config.yml` with `baseurl: "/v3"`
3. The build script will automatically include it (update `build_all.sh` to add v3)
4. Push to main - GitHub Actions will deploy it to `/v3/`

## Customization

Each version has its own:
- `_config.yml` - Site configuration (title, baseurl, etc.)
- `index.md` - Homepage content
- `about.md` - About page
- `projects.md` - Projects page
- `resume.md` - Resume page
- `assets/css/custom.scss` - Custom styles
- `_posts/` - Blog posts
- `_sass/` - Sass partials

Shared assets in `shared/` are available to all versions.