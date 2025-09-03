# Complex Branching & Deployment Strategy

## Purpose

This document outlines `<<ORGANISATION>>`’s minimum required policies and procedures for the branching strategy and deployment process for applications developed within the Flok program. It defines the environments, branches, and operational guidelines to ensure a structured and reliable software development lifecycle.

## Environments

The standard deployment structure includes the following environments:

- **Local Development Environment (LDE)**: Used by developers for local development and testing.
    
- **Development (dev)**: Environment for integrating and testing code changes.
    
- **Staging (stg)**: Environment for non-technical users to validate features before production.
    
- **Production (prd)**: Live environment for the application used by end customers.
    
- **Master**: Represents the public release of the code, used across all customer instances.
    

## Branch Structure

Each application repository maintains the following branches:

|   |   |
|---|---|
|Branch|Description|
|master|Public release code, used for all instances, not tied to a single customer.|
|prod|Current code running in the production environment.|
|release|Code prepared for the next production release.|
|staging|Code running in the staging environment for non-technical user testing.|
|stg|Code to be deployed to the staging environment.|
|develop|Code running in the development environment for integration and testing.|
|feature/<ticket-id>-<feature-name>|Feature branches for ongoing development, created from develop.|

## Operational Guidelines

### Branch Management

1. **Rebasing Hierarchy**:
    
    - Branches are rebased from top to bottom (e.g., master → prod → release → staging → stg → develop → feature branches).
        
    - Hotfixes applied to prod must propagate to all lower branches in the order: develop, stg, staging, release, and active feature branches.
        
2. **Feature Development**:
    
    - Create a new feature branch from the latest develop branch, named feature/<ticket-id>-<feature-name>.
        
    - Feature branches must be rebased onto develop regularly to incorporate updates.
        
    - Features lacking tests or CI implementation must not be merged into any common branches.
        
3. **Pull Requests**:
    
    - When a feature is ready, create a pull request to merge the feature branch into develop.
        
    - The pull request requires review and approval by at least one other team member.
        
    - Merging is allowed only if all changed microservice components pass tests.
        

### Deployment Process

1. **Staging Deployment**:
    
    - Deployments to the stg environment are made from the stg branch for non-technical user validation.
        
    - If issues arise or non-technical users reject the deployment, a rollback is performed to the previous stg state.
        
2. **Production Deployment**:
    
    - Once the staging branch is validated in the stg environment, merge it into the release branch using -X theirs and --allow-unrelated-histories flags.
        
    - Tag the release branch with a new version for traceability using git push --tags.
        
    - Deploy to the prod environment from the release branch.
        
3. **Hotfixes**:
    
    - For bugs fixable in under 4 hours, create a hotfix branch from release, deploy to stg for testing, and, if tests pass, deploy to prod with a new tag.
        
    - For bugs requiring more than 4 hours, create a priority-1 bug ticket and follow the standard deployment process.
        
4. **Post-Release**:
    
    - After business representatives approve the production deployment, rebase the prod branch with the release branch. The tagged release becomes the new "source of truth" for production.
        
    - If the deployment is not approved, rollback to the previous production commit.
        
    - Post-release, rebase develop and release branches from develop. All developers must rebase their feature/bugfix branches from develop, ensuring only changes related to their current work remain in the branch diff.
        

### Automation and Tooling

- **CI/CD**: All deployments to live environments (stg, prod) must use automated CI/CD pipelines, never manual processes.
    
- **Source Code Management System Integration**: All environment transitions are managed through the Source Code Management System.
    
- **Manual Triggering**: Deployments to different environments can be manually triggered via the Source Code Management System's Actions UI.
    

## Notes

- Ensure feature branches only contain changes relevant to the specific feature or bugfix.
    
- Regularly verify that CI pipelines include tests for all modified components to maintain code quality.
