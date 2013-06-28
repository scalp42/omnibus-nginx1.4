name            "nginx1.4"
maintainer      "Myroslav Rys"
homepage        "http://nginx.org"

replaces        "nginx"
install_path    "/opt/nginx1.4"
build_version   "1.4.1"
build_iteration 1

# nginx dependencies/components
dependency      "preparation"
dependency      "nginx1.4"
dependency      "version-manifest"

# version manifest file
# dependency "version-manifest"

exclude         "\.git*"
exclude         "bundler\/git"
