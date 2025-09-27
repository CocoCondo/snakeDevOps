multibranchPipelineJob('UCU-DevOps') {
  displayName('UCU-DevOps (Multibranch)')
  branchSources {
    git {
      id('ucu-devops-git')
      remote('https://github.com/cardo88/UCU-DevOps.git') // TODO
      includes('*')
    }
  }
  factory {
    workflowBranchProjectFactory {
      scriptPath('Jenkinsfile')
    }
  }
  orphanedItemStrategy {
    discardOldItems { numToKeep(10) }
  }
}