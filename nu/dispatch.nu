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
    mut failed = false
    for rule in $config.dispatch {
        let workflow = $rule | reject repository | default {}
        let workflow = $config.default.workflow? | default {} | merge $workflow
        
        dispatch $rule.repository $workflow
          | if ($in.error? | is-not-empty) {
                let err = if ($in.error.message? | is-not-empty) { $in.error.message } else { $in.error | to text }
                gh core error $"($err) \(dispatch failed ($workflow.name)@($rule.repository))"
                $failed = true
            }
    }
    if $failed { exit 1 }
}

def main [] {
    dispatch_loop
}
