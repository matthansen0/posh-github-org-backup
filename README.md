# GitHub Backup
PowerShell to backup repositories from a GitHub organization locally. There is an additional optional flag for repos outside the org.

Example: 

``.\backup-repos.ps1 -Username "your-username" -Token "your-token" -OrgName "" -BackupDir "C:\backups"``

The backup created with the ``git clone --mirror`` command creates a bare repository that contains all branches, tags, and commits, as well as any other Git metadata for the repository. This means that you can use the backup to restore the full history and contents of the repository, including any branches or tags that may have been deleted.

## Restoration

To restore a repository from a backup, you can use the ``git clone`` command to create a new clone of the repository on your local machine. You can then use the ``git push`` command to upload the contents of the backup to a new repository on GitHub.

Here's an example of how you can restore a repository from a backup:

1. Open a terminal or command prompt.

2. Navigate to the directory where you want to restore the repository.

3. Run the following command to clone the backup: ``git clone --mirror /path/to/backup.git``

Replace /path/to/backup.git with the path to the backup repository on your local machine.

4. Navigate to the cloned repository: ``cd backup.git``

5. Create a new repository on GitHub with the same name as the original repository.

6. Set the remote URL of the cloned repository to the new repository on GitHub:

``git remote set-url origin https://github.com/<your-username>/<new-repo-name>.git``

Replace <your-username> with your GitHub username, and <new-repo-name> with the name of the new repository you created in step 5.

7. Push the contents of the backup to the new repository on GitHub: ``git push --mirror``

This will upload all branches, tags, and commits from the backup to the new repository on GitHub.

Once you've pushed the backup to the new repository on GitHub, you should be able to access your commit history and other repository data as usual.

It's important to note that restoring a repository from a backup will not restore any issues, pull requests, or other data associated with the original repository on GitHub. It will only restore the contents of the repository itself. If you need to restore other repository data, such as issues or pull requests, you may need to use a different backup and restore process.
