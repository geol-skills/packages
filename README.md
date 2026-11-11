# geol-skills R packages

A [drat](https://eddelbuettel.github.io/drat/) repository of R packages for
the geol-skills course, served at <https://geol-skills.github.io/packages>.

| Package | Purpose |
|---|---|
| [BGS](https://github.com/geol-skills/BGS) | Bedrock and superficial deposits at a point, on land or at sea |

## Install

```r
install.packages(
  "BGS",
  repos = c("https://geol-skills.github.io/packages", getOption("repos"))
)
```

In webR, or a quarto-live page:

```r
webr::install("BGS", repos = "https://geol-skills.github.io/packages")
```

## Maintenance

`.github/workflows/build-bgs.yml` publishes each new version of BGS (a new
`Version:` in its DESCRIPTION) within a day, or at once when run by hand
(Actions → build-bgs → Run workflow). It then installs the package from the
live site on Windows, macOS, Linux and webR.

Packages here are pure R, so there are no Windows or macOS binaries: empty
`PACKAGES` files under `bin/` let R fall back to source without a warning.
The webR binary is built for the webR release that the course site's
quarto-live extension loads; when that changes, update `WEBR_IMAGE` and
`WEBR_NPM` in the workflow.
