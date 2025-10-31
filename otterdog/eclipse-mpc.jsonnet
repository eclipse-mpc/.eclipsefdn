// see https://github.com/EclipseFdn/otterdog-defaults/blob/main/otterdog-defaults.libsonnet
local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

// see https://otterdog.readthedocs.io/en/latest/reference/organization/
orgs.newOrg('technology.packaging.mpc', 'eclipse-mpc') {
  settings+: {
    description: "",
    name: "Eclipse MPC",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/mpc/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push",
      ],
    },
  ],
  _repositories+:: [
    // see https://otterdog.readthedocs.io/en/latest/reference/organization/repository/#repository
    orgs.newRepo('epp.mpc') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "The Eclipse Marketplace Client provides a rich client for installing solutions listed on Eclipse Marketplace",
      homepage: "https://projects.eclipse.org/projects/technology.packaging.mpc",
      squash_merge_commit_message: "PR_BODY",
      squash_merge_commit_title: "PR_TITLE",
      topics+: [
        "eclipse",
        "eclipse-plugin",
        "java"
      ],
      web_commit_signoff_required: false
    },
    orgs.newRepo('mpc-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}
