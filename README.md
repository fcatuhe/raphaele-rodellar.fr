# raphaele-rodellar.fr

## Staging

Any push to staging will trigger the GitHub Action to deploy.

## Production

GitHub Action to deploy is restricted to the `main` branch.
The restriction comes from the `github-pages` environment selected deployment branch.
