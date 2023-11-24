# raphaele-rodellar.fr

## Development

- `middleman` to start server
- `middleman build -e production` to build as Production environment
  - `middleman build -e production --verbose`

## Staging

- push to `staging` remote will trigger `middleman-deploy-staging` GitHub Action

## Production

- `middleman-deploy` GitHub Action is restricted to the `main` branch
