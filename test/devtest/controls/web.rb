title 'Unit Testing AWS Infrastructure'

# load data from terraform output
content = inspec.devtest.file("terraform.json")
params = JSON.parse(content)

VPC_ID = params['vpc_id']['value']
ALB_DNS = params['alb_dns']['value']

# testcase for vpc
describe aws_vpc(VPC_ID) do
  it ('state') { should exist }
  its ('state') { should eq 'available' }
  its('cidr_block') { should cmp '10.0.0.0/16' }
  its ('instance_tenancy') { should eq 'default' }
  its('tags') { should include(:Name => 'primary') }
end

# testcase for ec2 instances
describe aws_ec2_instances do
  it { should be_running }
  its('name') { should cmp 'Web_Server' }
  its('instance_ids_count') { should cmp 2 }
  its('key_name') { should cmp 'my_ec2_keypair' }
  its('instance_type') { should eq 't2.micro' }
  its('image_id') { should eq 'ami-0447a12f28fddb066' }
end

# testcase for load balancer
describe aws_alb(ALB_DNS) do
  it { should exist }
  its('dns_name') { should cmp 'appalb' }
  its('availability_zones.count') { should be > 1 }
  its('state') {should be 'provisioned'}
  its('instance_ids.count') { should cmp 2 }
end

