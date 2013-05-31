# Clone Gitlab Shell
git "gitlab shell" do
  repository  "https://github.com/gitlabhq/gitlab-shell.git"
  revision    node['gitlab']['shell_revision']
  destination node['gitlab']['shell_path']
  user        node['gitlab']['user']
  group       node['gitlab']['group']
  action      :sync
end

template "gitlab-shell/config.yml" do
  path        File.join(node['gitlab']['shell_path'], 'config.yml')
  user        node['gitlab']['user']
  group       node['gitlab']['group']
  source      "gitlab_shell_config.yml.erb"
  notifies    :run, "execute[gitlab install]", :immediately
end

execute "gitlab install" do
  command     "./bin/install"
  cwd         node['gitlab']['shell_path']
  user        node['gitlab']['user']
  action      :nothing
end