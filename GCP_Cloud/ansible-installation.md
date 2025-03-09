# Run Ansible in a detached Docker container
docker run -d --name ansible \
  --restart=always \
  --network host \
  -v $(pwd)/ansible:/ansible \
  -v ~/.ssh:/root/.ssh \
  -w /ansible \
  cytopia/ansible:latest tail -f /dev/null

# OR (Alternative method)
docker run -dit --name ansible \
  -v ~/ansible-playbooks:/ansible-playbooks \
  cytopia/ansible:latest sh

# Execute playbook
ansible-playbook -i inventory.ini setup_bioturing_playbook.yml --ask-vault-pass --extra-vars "gpu_enabled=yes"