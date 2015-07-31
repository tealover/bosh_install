#/bin/bash

dt=`date '+%Y%m%d-%H%M%S'`
logfile="install_$dt.log"

function add_hostname() {
    localip=`ifconfig | grep -v 127.0.0.1 | grep inet | grep -v inet6 | awk '{print $2}' | sed 's/addr://'`
    hostname=`hostname`
    sed -i "/.* $hostname/d" /etc/hosts
    echo "$localip $hostname" >> /etc/hosts
}

function pre_install() {
    yum install -y net-tools | tee -a $logfile 
    yum install -y unzip | tee -a $logfile
    add_hostname
}

function install_tools() {
    yum -y install gcc | tee -a $logfile
    yum -y install gcc-c++ | tee -a $logfile
    yum -y install ruby | tee -a $logfile
    yum -y install ruby-devel | tee -a $logfile
    yum -y install mysql-devel | tee -a $logfile
    yum -y install postgresql-devel | tee -a $logfile
    yum -y install postgresql-libs | tee -a $logfile
    yum -y install sqlite-devel | tee -a $logfile
    yum -y install libxslt-devel | tee -a $logfile
    yum -y install libxml2-devel | tee -a $logfile
    yum -y install yajl-ruby| tee -a $logfile
}

function install_bosh_deps() {
    gem install --no-ri --no-rdoc --local ./gems/builder-3.1.4.gem
    gem install --no-ri --no-rdoc --local ./gems/mime-types-1.25.1.gem
    gem install --no-ri --no-rdoc --local ./gems/bundler-1.10.5.gem
    gem install --no-ri --no-rdoc --local ./gems/bundle-0.0.1.gem
    gem install --no-ri --no-rdoc --local ./gems/rake-10.4.2.gem
    gem install --no-ri --no-rdoc --local ./gems/mini_portile-0.6.2.gem
    gem install --no-ri --no-rdoc --local ./gems/nokogiri-1.6.5.gem  -- --use-system-libraries
}

function install_bosh_cli() {
    gem install  --no-ri --no-rdoc --local ./gems/semi_semantic-1.1.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/little-plugger-1.1.3.gem
    gem install  --no-ri --no-rdoc --local ./gems/multi_json-1.11.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/logging-1.8.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/bosh_common-1.3012.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/bosh-template-1.3012.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/cf-uaa-lib-3.2.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/json_pure-1.8.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/highline-1.6.21.gem
    gem install  --no-ri --no-rdoc --local ./gems/progressbar-0.9.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/httpclient-2.4.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/terminal-table-1.4.5.gem
    gem install  --no-ri --no-rdoc --local ./gems/aws-sdk-v1-1.60.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/aws-sdk-1.60.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/excon-0.45.4.gem
    gem install  --no-ri --no-rdoc --local ./gems/formatador-0.2.5.gem
    gem install  --no-ri --no-rdoc --local ./gems/net-ssh-2.9.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/net-scp-1.1.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-core-1.32.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-json-1.0.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-xml-0.1.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/ipaddress-0.8.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-aws-0.1.1.gem
    gem install  --no-ri --no-rdoc --local ./gems/inflecto-0.0.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-brightbox-0.7.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-softlayer-0.4.7.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-sakuracloud-1.0.1.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-radosgw-0.0.4.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-profitbricks-0.0.3.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-voxel-0.1.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/CFPropertyList-2.3.1.gem
    gem install  --no-ri --no-rdoc --local ./gems/fission-0.5.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-vmfusion-0.1.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-terremark-0.1.0.gem 
    gem install  --no-ri --no-rdoc --local ./gems/fog-ecloud-0.3.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-storm_on_demand-0.1.1.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-atmos-0.1.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/fog-serverlove-0.1.2.gem 
    gem install  --no-ri --no-rdoc --local ./gems/fog-1.27.0.gem 
    gem install  --no-ri --no-rdoc --local ./gems/log4r-1.1.10.gem
    gem install  --no-ri --no-rdoc --local ./gems/ruby-hmac-0.4.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/ruby-atmos-pure-1.0.5.gem
    gem install  --no-ri --no-rdoc --local ./gems/blobstore_client-1.3012.0.gem 
    gem install  --no-ri --no-rdoc --local ./gems/net-ssh-2.9.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/net-ssh-gateway-1.2.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/net-scp-1.1.2.gem
    gem install  --no-ri --no-rdoc --local ./gems/netaddr-1.5.0.gem
    gem install  --no-ri --no-rdoc --local ./gems/minitar-0.5.4.gem 
    gem install  --no-ri --no-rdoc --local ./gems//bosh_cli-1.3012.0.gem
}

function install_bosh_cli_plugin_micro() {
   gem install --no-ri --no-rdoc --local ./gems/sqlite3-1.3.10.gem
   gem install --no-ri --no-rdoc --local ./gems/mono_logger-1.1.0.gem
   gem install --no-ri --no-rdoc --local ./gems/gibberish-1.4.0.gem
   gem install --no-ri --no-rdoc --local ./gems/yajl-ruby-1.2.1.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh-core-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/membrane-1.1.0.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh_cpi-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/sequel-3.43.0.gem
   gem install --no-ri --no-rdoc --local ./gems/rack-1.6.4.gem
   gem install --no-ri --no-rdoc --local ./gems/tilt-2.0.1.gem
   gem install --no-ri --no-rdoc --local ./gems/rack-protection-1.5.3.gem
   gem install --no-ri --no-rdoc --local ./gems/sinatra-1.4.6.gem
   gem install --no-ri --no-rdoc --local ./gems/eventmachine-1.0.7.gem
   gem install --no-ri --no-rdoc --local ./gems/daemons-1.2.3.gem
   gem install --no-ri --no-rdoc --local ./gems/thin-1.5.1.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh-registry-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh_aws_cpi-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh-stemcell-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/agent_client-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh_openstack_cpi-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/rest-client-1.6.9.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh_vcloud_cpi-0.7.7.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh_vsphere_cpi-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh-director-core-1.3012.0.gem
   gem install --no-ri --no-rdoc --local ./gems/bosh_cli_plugin_micro-1.3012.0.gem

}

function post_install() {
   echo "completed to install bosh cli and bosh cli plugin micro" 
}

pre_install
install_tools
install_bosh_deps
install_bosh_cli
install_bosh_cli_plugin_micro
post_install
