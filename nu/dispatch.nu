use std/log
use gh
source common/git.nu
source common/env.nu


def dispatch [
    repository: string  # workflow dispatch repository
    workflow: record    # workflow dispatch config
] {
    log debug $"=> dispatch repository: ($repository), workflow: ($workflow.name)"
    gh workflow run get-dispatched $workflow.name --repo=$repository --inputs=$workflow.inputs
}

def dispatch_loop [] {
    let config = open $'(git_root)/.github/.dispatch.yaml'

    # loop over the disptach list
    for rule in $config.dispatch {
        let workflow = $rule | reject repository | default {}
        let default = $config.default.workflow? | default {}

        dispatch $rule.repository ($default | merge $workflow)
    }
}

def main [] {
    dispatch_loop
}
