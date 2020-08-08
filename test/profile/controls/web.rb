title 'web application setup'

# load data from terraform output
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

INSTANCE_ID = params['instance_id']['value']
VPC_ID = params['vpc_id']['value']

# execute test
describe aws_vpc(vpc_id: VPC_ID) do
  its('cidr_block') { should cmp '10.0.0.0/16' }
end

describe aws_ec2_instance(INSTANCE_ID) do
  it { should be_running }
  its('instance_type') { should eq 't2.micro' }
  its('image_id') { should eq 'ami-0447a12f28fddb066' }
end