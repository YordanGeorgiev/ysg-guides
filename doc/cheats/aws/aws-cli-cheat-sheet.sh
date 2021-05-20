# file: docs/cheat-sheets/aws/aws-cli-cheat-sheet.sh



export AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials.mac

aws iam list-roles --profile spectralengines_master_devtest_admin| jq -r '.Roles[]|to_entries[]|select(.key=="RoleName" or .key == "RoleId" or .key == "Description")|"\(.key): \(.value)"' | perl -ne 's|RoleName|\nRoleName|g;print'



aws iam get-account-authorization-details
aws sts get-caller-identity

aws iam list-roles --profile spectralengines_master_devtest_admin --region us-east-1 \
	| jq -r '.Roles[]|to_entries[]|select(.key=="Arn" or .key == "RoleId")|"\(.key): \(.value)"'

aws secretsmanager get-secret-value --secret-id se_cloudflare_credentials --region us-east-1 --profile spectralengines_master_prod_admin | jq '.'
aws secretsmanager update-secret --secret-id arn:aws:secretsmanager:us-east-1:123456789013:secret:cross-account --secret-string file://creds.txt
aws secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:us-east-1:123456789013:secret:cross-account --version-stage AWSCURRENT --profile cross-account-user --region us-east-1 --query SecretString --output text

aws rds modify-db-instance --db-instance-identifier mydb --master-user-password mypassword

aws sts get-caller-identity | jq '.'

Cloudwatch
Log Groups
http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/WhatIsCloudWatchLogs.html 
http://docs.aws.amazon.com/cli/latest/reference/logs/index.html#cli-aws-logs

create a group
http://docs.aws.amazon.com/cli/latest/reference/logs/create-log-group.html

aws logs create-log-group \
	--log-group-name "DefaultGroup"
list all log groups
http://docs.aws.amazon.com/cli/latest/reference/logs/describe-log-groups.html

aws logs describe-log-groups

aws logs describe-log-groups \
	--log-group-name-prefix "Default"
delete a group
http://docs.aws.amazon.com/cli/latest/reference/logs/delete-log-group.html

aws logs delete-log-group \
	--log-group-name "DefaultGroup"


# check my aws cashe
while read -r f ; do echo start $f; cat $f | jq '.' ; echo stop $f ; done < <(find ~/.aws/cli/cache/ -type f)


aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,PublicIpAddress,KeyName,Tags[?Key==`Name`]| [0].Value]' --output=text



aws s3 ls --recursive s3://prd-hydeout-backend-biz-api/avatars awk '{print $4}' | \
	while read -r key ; do aws s3api put-object-acl --bucket  prd-hydeout-backend-biz-api --acl public-read --key "$key"; done

aws s3api put-bucket-policy --bucket tst-hydeout-backend-biz-api --policy file://cnf/aws/s3/policies/tst-hydeout-backend-biz-api.policy.json

aws s3api list-buckets | jq -r '.Buckets[].Name'|sort


aws cloudformation create-stack --region eu-north-1 --template-body file://dat/json/ec2.i-038414c13163ea515.json stack-ho-v050-dev
aws ec2 describe-instances --instance-ids i-038414c13163ea515 | jq '.'
aws ec2 describe-instances --filters "Name=tag-key,Values=Name"


   while read -r key_pair_id; do
      aws echo ec2 delete-key-pair --key-name $key_pair_id ;
   done < <(aws ec2 describe-key-pairs | jq -r '.[] | .[] | .KeyPairId')
   

# find for s3 bucket
aws s3api --profile $aws_profile --endpoint-url=$end_point_url \
list-objects --bucket $bucket_name --query 'Contents[].{Key: Key}'

# how-to upload a dir into a s3 bucket
aws s3 cp $src_dir s3://$tgt_bucket --recursive


# aws ec2

# how-to list the ec2 instances and their tags
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,Tags[*]]'

# how-to list the ec2 instances and their tags
while read -r i ; do \
aws ec2 describe-tags --filters "Name=resource-id,Values=$i" \
--profile prd; done < <(aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].InstanceId' --profile prd)

# enable monitoring on all the ec2 instances
while read -r i ; do \
aws ec2 monitor-instances --instance-id "$i" --profile prd ; done \
 < <(aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].InstanceId' --profile prd)


aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --profile prd | sort


# how-to get all the tags per virtual-private-cloud-id 
while read -r v; do aws ec2 describe-tags \
--filters "Name=resource-id,Values=$v" ; \
done < <(aws ec2 describe-vpcs \
--query 'Vpcs[*].VpcId'|perl -ne 's/\t/\n/g;print')


# print all the iam roles visible to the this account
echo $(aws iam list-roles --query 'Roles[*].RoleName' --output=json) | \
perl -ne 'use JSON; foreach $e (@{decode_json ($_)}){print "$e\n"}' | \
sort



# how-to list all the ec2 regions 
aws ec2 describe-regions --output text --profile dev| cut -f 3


# aws s3
# how-to list all the buckets of the current aws profile
aws s3 ls


# foreach stack in prod describe stack resources
while read -r stack ; do \
echo -e "\nSTART $stack\n" ;\
aws cloudformation describe-stack-resources --stack-name $stack --profile prd ; \
echo -e "\nSTOP  $stack \n" ; done \
< <(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE \
--query "StackSummaries[*].StackName" --profile prd \
| perl -ne 's/\s+/\n/g;print'| sort)

while read -r i ; do aws ec2 describe-instance-attribute --instance-id $i --attribute instanceInitiatedShutdownBehavior; done < <(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId')


# how-to loop trough all your lb instances 
while read -r lb ; do \
	echo -e "\n\n start lb: $lb " ; \
	echo run cmd on lb: $lb ; \
	echo " stop  lb: $lb" ; \
done < <(aws elb describe-load-balancers --query \
'LoadBalancerDescriptions[].Instances[].InstanceId' \
--profile rnd|perl -nle 's/\s+/\n/g;print')



aws ec2 describe-internet-gateways --output=text --profile dev
aws ec2 monitor-instances --instance-ids i-01270f00db51 --region us-east-1 --output=text --profile dev

# how-to print all the vpc's
aws ec2 describe-vpcs --query 'Vpcs[*].VpcId'|perl -ne 's/\t/\n/g;print'


# aws elb
aws elb describe-load-balancers  --profile dev | grep -i listener


# aws route53 
aws route53 list-resource-record-sets --hosted-zone-id  "$hosted_zone_id" --profile dev


# test the dns answer in the aws route53
for record_type in $record_types ; do \
 aws route53  test-dns-answer \
  --hosted-zone-id "$hosted_zone_id" \
  --record-name "$record_name" \
  --record-type "$record_type" \
  --resolver-ip "$resolver_ip" \
  --profile "dev" ;
done


# aws iam
aws iam list-server-certificates --profile dev

# how-to list all the role names your aws account is having to
aws iam list-roles --query 'Roles[*].RoleName'|perl -ne 's/\t/\n/g;print'

# how-to list all the usernames in a
while read -r u; do \
echo $u ; \
done < <(aws iam list-users --query 'Users[*].UserName'|perl -ne 's/\t/\n/g;print')

# upload a preformatted ssl certificates
aws iam upload-server-certificate \
	--server-certificate-name "$server_certificate_name" \
	--certificate-body file://"$certificate_body_file" \ # BEGIN CERTIFICATE -> END CERTIFICATE
	--certificate-chain file://"$cerftificate_chain_file" \ 
	--private-key file://"$private_key_file" \ # rsa start -> rsa stop
	--profile dev

# install aws cli via python pip package manager
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" 
sudo python get-pip.py
sudo pip install --upgrade awscli
sudo apt-get install python-pip
sudo pip install awscli



# or via os package manager 
# install the aws-cli package
sudo apt-get install -y awscli
sudo yum install -y awscli

# aws cloudformation 
aws cloudformation describe-stacks --output=table --profile dev


# in aws admin console :
# Services => iam => users => <<your_username>> => Security Credentials => Access Keys
# configure the aws cli
cat << "EOF" > ~/.aws/credentials
[dev]
aws_access_key_id = <<your_aws_access_key_id_in_the_dev_environment>>
aws_secret_access_key = <<your_aws_secret_access_key_in_dev_env>>
[dev]
aws_access_key_id = <<your_aws_access_key_id_in_the_dev_environment>>
aws_secret_access_key = <<your_aws_secret_access_key_in_dev_env>>
[default]
aws_access_key_id = <<your_aws_access_key_id_in_the_dev_environment>>
aws_secret_access_key = <<your_aws_secret_access_key_in_dev_env>>
EOF

# set-up the ~/.boto confs
cat << "EOF" > ~/.boto
[profile dev]
aws_access_key_id = <<your_aws_access_key_id_in_the_dev_environment>>
aws_secret_access_key = <<your_aws_secret_access_key_in_dev_env>>
[profile dev]
aws_access_key_id = <<your_aws_access_key_id_in_the_dev_environment>>
aws_secret_access_key = <<your_aws_secret_access_key_in_dev_env>>
[profile default]
aws_access_key_id = <<your_aws_access_key_id>>
aws_secret_access_key = <<your_aws_secret_access_key_in_dev_env>>
EOF


# how-to configure your default regions and formats
# src: http://docs.aws.amazon.com/cli/latest/topic/config-vars.html
cat << "EOF" > ~/.aws/config

[profile dev]
output = text
region = us-east-1
[profile dev]
output = text
region = us-east-1
[default]
output = text
region = Global

EOF 


# src:
https://wblinks.com/notes/aws-tips-i-wish-id-known-before-i-started/



# create a bucket name, using the current date timestamp
bucket_name=test_$(date "+%Y-%m-%d_%H-%M-%S") ; echo $bucket_name

# create a public facing bucket
aws s3api create-bucket --acl "public-read-write" --bucket $bucket_name

# verify bucket was created
aws s3 ls | grep $bucket_name

# check for public facing s3 buckets (should show the bucket name you created)
aws s3api list-buckets --query 'Buckets[*].[Name]' --output text | xargs -I {} bash -c 'if [[ $(aws s3api get-bucket-acl --bucket {} --query '"'"'Grants[?Grantee.URI==`http://acs.amazonaws.com/groups/global/AllUsers` && Permission==`READ`]'"'"' --output text) ]]; then echo {} ; fi'

# check for public facing s3 buckets, updated them to be private
aws s3api list-buckets --query 'Buckets[*].[Name]' --output text | xargs -I {} bash -c 'if [[ $(aws s3api get-bucket-acl --bucket {} --query '"'"'Grants[?Grantee.URI==`http://acs.amazonaws.com/groups/global/AllUsers` && Permission==`READ`]'"'"' --output text) ]]; then aws s3api put-bucket-acl --acl "private" --bucket {} ; fi'

# check for public facing s3 buckets (should be empty)
aws s3api list-buckets --query 'Buckets[*].[Name]' --output text | xargs -I {} bash -c 'if [[ $(aws s3api get-bucket-acl --bucket {} --query '"'"'Grants[?Grantee.URI==`http://acs.amazonaws.com/groups/global/AllUsers` && Permission==`READ`]'"'"' --output text) ]]; then echo {} ; fi'



# ec2 Instances
http://docs.aws.amazon.com/cli/latest/reference/ec2/index.html

# list all instances (running, and not running)
# http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
aws ec2 describe-instances

# list all instances running
aws ec2 describe-instances --filters Name=instance-state-name,Values=running

# create a new instance
# http://docs.aws.amazon.com/cli/latest/reference/ec2/run-instances.html
aws ec2 run-instances \
    --image-id ami-f0e7d19a \	
    --instance-type t2.micro \
    --security-group-ids sg-00000000 \
    --dry-run

# stop an instance
# http://docs.aws.amazon.com/cli/latest/reference/ec2/terminate-instances.html
aws ec2 terminate-instances \
    --instance-ids <instance_id>

# list status of all instances
# http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instance-status.html
aws ec2 describe-instance-status

# list status of a specific instance
aws ec2 describe-instance-status \
    --instance-ids <instance_id>
    
# list all running instance, Name tag and Public IP Address
aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  --query 'Reservations[].Instances[].[PublicIpAddress, Tags[?Key==`Name`].Value | [0] ]' \
  --output text | sort -k2


Groups, Policies, Managed Policies
http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html http://docs.aws.amazon.com/cli/latest/reference/iam/

# list all groups
aws iam list-groups

# create a group
aws iam create-group --group-name FullAdmins

# delete a group
aws iam delete-group \
    --group-name FullAdmins

# list all policies
aws iam list-policies

# get a specific policy
aws iam get-policy \
    --policy-arn <value>

# list all users, groups, and roles, for a given policy
aws iam list-entities-for-policy \
    --policy-arn <value>

# list policies, for a given group
aws iam list-attached-group-policies \
    --group-name FullAdmins

# add a policy to a group
aws iam attach-group-policy \
    --group-name FullAdmins \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# add a user to a group
aws iam add-user-to-group \
    --group-name FullAdmins \
    --user-name aws-admin2

# list users, for a given group
aws iam get-group \
    --group-name FullAdmins

# list groups, for a given user
aws iam list-groups-for-user \
    --user-name aws-admin2

# remove a user from a group
aws iam remove-user-from-group \
    --group-name FullAdmins \
    --user-name aws-admin2

# remove a policy from a group
aws iam detach-group-policy \
    --group-name FullAdmins \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# delete a group
aws iam delete-group \
    --group-name FullAdmins

# chk also the following info sources: 
https://gist.github.com/apolloclark/b3f60c1f68aa972d324b


Users
https://blogs.aws.amazon.com/security/post/Tx15CIT22V4J8RP/How-to-rotate-access-keys-for-IAM-users http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html Limits = 5000 users, 100 group, 250 roles, 2 access keys / user

http://docs.aws.amazon.com/cli/latest/reference/iam/index.html

# list all user's info
aws iam list-users

# list all user's usernames
aws iam list-users --output text | cut -f 6

# list current user's info
aws iam get-user

# list current user's access keys
aws iam list-access-keys

# crate new user
aws iam create-user \
    --user-name aws-admin2

# create multiple new users, from a file
allUsers=$(cat ./user-names.txt)
for userName in $allUsers; do
    aws iam create-user \
        --user-name $userName
done

# list all users
aws iam list-users --no-paginate

# get a specific user's info
aws iam get-user \
    --user-name aws-admin2

# delete one user
aws iam delete-user \
    --user-name aws-admin2

# delete all users
# allUsers=$(aws iam list-users --output text | cut -f 6);
allUsers=$(cat ./user-names.txt)
for userName in $allUsers; do
    aws iam delete-user \
        --user-name $userName
done

# info-sources
# https://ilya-sher.org/2016/05/11/most-jq-you-will-ever-need/
# eof file: docs/cheat-sheets/aws/aws-cli-cheat-sheet.sh
