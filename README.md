# Raphaële Rodellar — Rails Static Site

This repository contains the static version of [raphaele-rodellar.fr](https://raphaele-rodellar.fr), now powered by the [Rails Static](https://rails-static.com) stack. The previous Middleman implementation has been migrated to Rails so we can keep working in a familiar framework while still publishing a pre-rendered site.

## Requirements

- Ruby 3.3+
- Bundler 2.7.x (`gem install bundler -v 2.7.1` if needed)
- Node.js is **not** required

## Getting started

```bash
bundle install
bin/setup
bin/dev
```

`bin/dev` boots the Hotwire Spark development environment (Rails server + live reload). The site lives at `http://localhost:3000` by default.

### Content structure

- `content/pages/*.html.erb` — Static pages rendered with ERB (home, curieux, bibliotheque, voyage…)
- `content/books/*.html.md` — Library articles written in Markdown front matter, rendered through `Book` records
- `content/voyage/*.md` — Markdown snippets used for the *Voyage au cœur d'une séance* modals
- `config/categories.yml` — Category metadata (title, tag and colors) used by the library

All pages keep their original HTML so very little rewriting is required when editing content.

### Assets

- Styles are bundled in `app/assets/stylesheets/application.css` (compiled from the legacy SCSS)
- Images live in `app/assets/images`
- Custom fonts are served from `app/assets/fonts`
- Newsletter form behaviour is handled by the Stimulus controller in `app/javascript/controllers/curious_controller.js`

## Building the static site

We use [Parklife](https://parklife.dev) to crawl the Rails app and emit a static build.

```bash
bundle exec parklife build
```

The output goes to the `build/` directory and includes an auto-generated `sitemap.xml(.gz)` plus `robots.txt` pointing to it.

## Deployment

Parklife is already configured to target `https://raphaele-rodellar.fr`. Once the build is produced, push the contents of `build/` to GitHub Pages (or the hosting of your choice).

## Notable helpers

- `ApplicationHelper` exposes `site_url`, `render_markdown`, and breadcrumb helpers for the “Curieux ?” section
- `LibraryHelper` loads categories and organizes books by tag
- `VoyageHelper` renders the 24 voyage snippets from Markdown

## Updating content

- **Home page**: `content/pages/index.html.erb`
- **Curious? landing**: `content/pages/curieux.html.erb`
- **Library index**: `content/pages/bibliotheque.html.erb`
- **Library articles**: files in `content/books/` (front matter controls title, subtitle, author, publisher, tags)
- **Voyage modals**: Markdown files in `content/voyage/`

After editing, rebuild with `bundle exec parklife build` so the sitemap and robots files stay in sync.
