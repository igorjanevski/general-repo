# Script for migration of BitBucket repositories to Azure DevOps
# It requires a list of repositories as input within a project

# Prerequisites
# - az login
# - admin rights on BitBucket and Azure DevOps

while read p; do
  repo=`echo $p | sed -e 's/[[:space:]]*$//'`
  echo "Migrating Bitbucket repository: $repo"
  
  # Clone the Bitbucket repo locally
  git clone --mirror https://bitbucket.org.com/scm/some_project/$repo.git
  
  # Create ADO repository
  az repos create --name $repo -p some_project --org https://dev.azure.com/org
  
  # Push the repo to ADO
  cd $repo.git
  git push --mirror https://target@dev.azure.com/org/project/_git/$repo
  cd ..
  
done <list-repos.txt
