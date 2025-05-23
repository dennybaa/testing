use gh
use std

# let git_root = git rev-parse --show-toplevel
# let config = open $'($git_root)/.github/.dispatch.yaml'

# def log [
#     level: string           # Log level
#     message: string         # A message
#     --short (-s)            # Whether to use a short prefix
#     --format (-f): string   # A format (for further reference: help std log)
# ] {
#     # print $args
#     # std log $'($level)' $message
# }

# def dispatch [] {
#     let rules = ($config.dispatch? | default [])
# }


# # log info "Hello"

# let cmd = "date"
# do { $cmd } now
