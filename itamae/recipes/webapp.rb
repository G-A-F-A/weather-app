# nginx
template "/etc/nginx/nginx.conf" do
  source "../templates/nginx/nginx.conf"
  notifies :restart, "service[nginx]"
end
service 'nginx' do
  action [:enable, :start]
end
