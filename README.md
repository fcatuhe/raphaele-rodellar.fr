# Raphaële Rodellar — Rails Static Site

This repository contains the static version of [raphaele-rodellar.fr](https://raphaele-rodellar.fr), now powered by the [Rails Static](https://rails-static.com) stack. The previous Middleman implementation has been migrated to Rails so we can keep working in a familiar framework while still publishing a pre-rendered site.

## Requirements

- Ruby 3.4+
- Rails 8.1+

## Getting started

```bash
bundle install
bin/dev
```

`bin/dev` boots the Hotwire Spark development environment (Rails server + live reload). The site lives at `http://localhost:3000` by default.

### Content structure

- `content/pages/*.html.erb` — Static pages rendered with ERB (home, curieux, bibliotheque, voyage…)
- `content/books/*.html.md` — Library articles written in Markdown front matter, rendered through `Book` records
- `content/voyage/*.md` — Markdown snippets used for the *Voyage au cœur d'une séance* modals
- `data/categories.yml` — Category metadata (title, tag and colors) used by the library

All pages keep their original HTML so very little rewriting is required when editing content.

### Assets

- Styles are included from `app/assets/stylesheets`
- Images live in `app/assets/images`
- Custom fonts are served from `app/assets/fonts`

## Building the static site

We use [Parklife](https://parklife.dev) to crawl the Rails app and emit a static build.

```bash
bin/static-build
```

This script precompiles assets, runs Parklife, and copies public files to the `build/` directory. It also generates `sitemap.xml(.gz)` and `robots.txt`.

For local testing, you can also run `bundle exec parklife build` directly.

## Deployment

### Production

Pushing to `main` triggers GitHub Actions to automatically build and deploy to GitHub Pages at `https://raphaele-rodellar.fr`.

### Staging

To preview changes before production, push your branch to the `staging` remote:

```bash
git push staging
```

The staging site has a separate GitHub repository with `STAGING=true` configured. This:
- Generates `robots.txt` with `Disallow: /` to block search engines
- Adds `noindex, nofollow` meta tags to all pages

To set up staging for the first time:

```bash
git remote add staging git@github.com:fcatuhe/staging.raphaele-rodellar.fr.git
```

## Code quality

```bash
bin/rubocop        # Lint Ruby code (Rails Omakase style)
bin/brakeman       # Security vulnerability scan
```

## Notable patterns

- `ApplicationHelper` exposes `render_erb`, `render_markdown`, `canonical_url`, `og_meta_tags`, and `main_class` helpers
- `BookCategory` model loads categories from YAML and provides `books` association
- `Book.with_tag(tag)` filters books by category tag
- `Voyage` model provides content for the voyage snippets (24 numbered + intro/conclusion)
- `Meta` and `Current` use `CurrentAttributes` for request-scoped state (SEO metadata, breadcrumbs)

## Updating content

- **Home page**: `content/pages/index.html.erb`
- **Curious? landing**: `content/pages/curieux.html.erb`
- **Library index**: `content/pages/bibliotheque.html.erb`
- **Library articles**: files in `content/books/` (front matter controls title, subtitle, author, publisher, tags)
- **Voyage modals**: Markdown files in `content/voyage/`
