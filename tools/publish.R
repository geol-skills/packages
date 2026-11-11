# Adds the artifacts built by .github/workflows/build-bgs.yml to this drat
# repository. Run from the repository root:
#   Rscript tools/publish.R artifacts

artifacts <- commandArgs(TRUE)[1]

source <- list.files(file.path(artifacts, "source"), "\\.tar\\.gz$",
                     full.names = TRUE)
stopifnot(length(source) == 1)
drat::insertPackage(source, repodir = ".", action = "archive",
                    commit = FALSE)

# webR binaries, laid out as bin/emscripten/contrib/<R version>/
wasm <- list.files(file.path(artifacts, "wasm"), "\\.tgz$", recursive = TRUE,
                   full.names = TRUE)
stopifnot(length(wasm) > 0)
for (file in wasm) {
  package <- sub("_.*", "", basename(file))
  target <- file.path("bin", "emscripten", "contrib", basename(dirname(file)))
  dir.create(target, recursive = TRUE, showWarnings = FALSE)
  unlink(list.files(target, paste0("^", package, "_.*\\.tgz$"),
                    full.names = TRUE))
  file.copy(file, target)
  tools::write_PACKAGES(target, type = "mac.binary")
}

# Packages here are pure R. Without a binary index, R on Windows and macOS
# warns before falling back to source; an empty index silences it.
binaries <- c("windows/contrib", "macosx/contrib",
              "macosx/big-sur-arm64/contrib", "macosx/big-sur-x86_64/contrib",
              "macosx/sonoma-arm64/contrib", "macosx/sonoma-x86_64/contrib")
for (dir in file.path("bin", rep(binaries, each = 10),
                      paste0("4.", 0:9))) {
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  if (!file.exists(file.path(dir, "PACKAGES"))) {
    file.create(file.path(dir, "PACKAGES"))
  }
}
