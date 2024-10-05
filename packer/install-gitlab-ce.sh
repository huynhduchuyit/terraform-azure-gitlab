# Install and configure the necessary dependencies
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

# Add the GitLab package repository and install the package
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get install gitlab-ce
