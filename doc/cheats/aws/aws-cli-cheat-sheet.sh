# file: docs/cheat-sheets/aws/aws-cli-cheat-sheet.sh

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

Src4Work!
Src4AWS!
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





# eof file: docs/cheat-sheets/aws/aws-cli-cheat-sheet.sh
