# Automating GitHub Branch Protection at Scale

Branch protection is crucial for maintaining code quality and security in any organisation. This blog post explores an automated system we've built to manage GitHub branch protection rules across multiple repositories.

## The Challenge

As organisations grow, manually configuring branch protection across dozens or hundreds of repositories becomes:
- Time-consuming
- Error-prone
- Difficult to audit
- Hard to maintain consistently

## Our Solution: GitHub Repository Rules Manager

We've built an automated system that enforces consistent branch protection rules across production repositories. Here's how it works:

### Automatic Repository Discovery

The system automatically identifies production repositories through several mechanisms:

1. **Repository Collection**: Python scripts query external sources (YAML/JSON files) containing repository information.
2. **Repository Cleaning**: The collected repository names are processed, removing duplicates and malformed entries.
3. **Centralised Storage**: Clean repository names are stored in a central `production-repos.json` file.

### GitHub Custom Properties

Once repositories are identified, the system:

1. **Defines Custom Properties**: Creates an organisation-level custom property called `is_production`.
2. **Applies Properties**: Sets this property to `true` on all production repositories.
3. **Verifies Application**: Confirms that properties are correctly applied via GitHub's API.

This creates a clear, searchable indicator of which repositories are production-grade.

### Infrastructure as Code

We use Terraform to manage our infrastructure:

1. **GitHub Ruleset Definition**: Creates organisation-wide rulesets targeted at production repositories.
2. **Branch Protection Configuration**: Configures protection rules including:
   - Linear history requirements
   - Deletion protection
   - Required pull request reviews
   - Approval requirements
3. **Administrative Bypass**: Configures admin teams that can bypass restrictions when necessary.

### Continuous Automation

The system runs through GitHub Actions workflows:

1. **Daily Repository Updates**: A scheduled workflow runs daily to:
   - Refresh the production repository list
   - Update custom properties
   - Commit changes automatically

2. **Terraform Deployment**: When changes are pushed to main:
   - Terraform plans are generated
   - Changes are automatically applied
   - Branch protection rules are updated

## Technical Architecture

### Component Interaction

```
┌─────────────────┐         ┌───────────────────┐         ┌──────────────────┐
│  External Data  │ ──────> │ Python Processing │ ──────> │ Repository List  │
└─────────────────┘         └───────────────────┘         └──────────────────┘
                                                                   │
                                                                   ▼
┌─────────────────┐         ┌───────────────────┐         ┌──────────────────┐
│  GitHub API     │ <────── │ Custom Properties │ <────── │ GitHub Actions   │
└─────────────────┘         └───────────────────┘         └──────────────────┘
        │                                                          │
        │                                                          │
        ▼                                                          ▼
┌─────────────────┐                                      ┌──────────────────┐
│  Branch Rules   │ <─────────────────────────────────── │ Terraform        │
└─────────────────┘                                      └──────────────────┘
```

### Key Technologies

- **Python**: For repository data processing
- **GitHub API**: For custom property management
- **Terraform**: For infrastructure management
- **GitHub Actions**: For workflow automation
- **Azure Storage**: For Terraform state management

## Security and Governance Benefits

This system provides several governance benefits:

1. **Consistent Security**: Enforces the same protection rules across all production repositories
2. **Audit Trail**: All changes to protection rules are tracked in version control
3. **Zero-Touch Maintenance**: New production repositories are automatically protected
4. **Reduced Human Error**: Eliminates manual configuration mistakes

## Conclusion

By automating GitHub branch protection, we've created a scalable, consistent, and low-maintenance system for securing our production codebase. This approach has significantly reduced the administrative overhead of managing branch protection at scale whilst improving our security posture.
