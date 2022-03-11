#!bin/bash
set -x 

properties=~/properties
devfile=.development.txt
testfile=.testing.txt
preprodfile=.staging.txt
prodfile=.production.txt

if [ "${properties}/laaopsproperties.txt" == `ls ~/properties/laaopsproperties.txt` ]; then
  echo -e "file already exists"
  cp $properties/laaopsproperties.txt $properties/.laaopsproperties
else
  cp -r properties ~
  cp $properties/laaopsproperties.txt $properties/.laaopsproperties
fi

#collect a list of environments and place them in a text file 
## DEV
aws-vault exec laa-development-lz -- aws ec2 describe-instances \
--filters Name=tag:Name,Values=ccms-* Name=instance-state-name,Values=running \
--query "Reservations [*].Instances[*].{Instance:PrivateIpAddress,AZ:Placement.AvailabilityZone,Name:Tags[?Key=='Name'].Value | [0]}"  \
--output text > $properties/.development.txt

## EBS
output=`awk '/eu-west-2a/ && /ccms-ebs DB Server/ { print $2 }' $properties/$devfile`
sed -i '' 's/ebs.dev.db=<INPUT>/ebs.dev.db='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-ebs App Server/ { print $2 }' $properties/$devfile`
sed -i '' 's/ebs.dev.appA=<INPUT>/ebs.dev.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-ebs App Server Two/ { print $2 }' $properties/$devfile`
sed -i '' 's/ebs.dev.appB=<INPUT>/ebs.dev.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-ebs App Server Three/ { print $2 }' $properties/$devfile`
sed -i '' 's/ebs.dev.appC=<INPUT>/ebs.dev.appC='${output}'/g' $properties/.laaopsproperties

## SOA
output=`awk '/ccms-soa-ecs-cluster-admin/ { print $2 }' $properties/$devfile`
sed -i '' 's/soa.dev.admin=<INPUT>/soa.dev.admin='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$devfile`
sed -i '' 's/soa.dev.appA=<INPUT>/soa.dev.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$devfile`
sed -i '' 's/soa.dev.appB=<INPUT>/soa.dev.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$devfile`
sed -i '' 's/soa.dev.appC=<INPUT>/soa.dev.appC='${output}'/g' $properties/.laaopsproperties

## EDRMS
output=`awk '/eu-west-2a/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/edrms.dev.appA=<INPUT>/edrms.dev.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/edrms.dev.appB=<INPUT>/edrms.dev.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/edrms.dev.appC=<INPUT>/edrms.dev.appC='${output}'/g' $properties/.laaopsproperties

## OPA
output=`awk '/eu-west-2a/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/opa.dev.appA=<INPUT>/opa.dev.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/opa.dev.appB=<INPUT>/opa.dev.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/opa.dev.appC=<INPUT>/opa.dev.appC='${output}'/g' $properties/.laaopsproperties

## PUI
output=`awk '/eu-west-2a/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/pui.dev.appA=<INPUT>/pui.dev.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/pui.dev.appB=<INPUT>/pui.dev.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$devfile`
sed -i '' 's/pui.dev.appC=<INPUT>/pui.dev.appC='${output}'/g' $properties/.laaopsproperties

## TEST
aws-vault exec laa-test-lz -- aws ec2 describe-instances \
--filters Name=tag:Name,Values=ccms-* Name=instance-state-name,Values=running \
--query "Reservations [*].Instances[*].{Instance:PrivateIpAddress,AZ:Placement.AvailabilityZone,Name:Tags[?Key=='Name'].Value | [0]}"  \
--output text > $properties/.testing.txt

## EBS
output=`awk '/eu-west-2a/ && /ccms-ebs DB Server/ { print $2 }' $properties/$testfile`
sed -i '' 's/ebs.test.db=<INPUT>/ebs.test.db='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-ebs App Server/ { print $2 }' $properties/$testfile`
sed -i '' 's/ebs.test.appA=<INPUT>/ebs.test.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-ebs App Server Two/ { print $2 }' $properties/$testfile`
sed -i '' 's/ebs.test.appB=<INPUT>/ebs.test.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-ebs App Server Three/ { print $2 }' $properties/$testfile`
sed -i '' 's/ebs.test.appC=<INPUT>/ebs.test.appC='${output}'/g' $properties/.laaopsproperties

## SOA
output=`awk '/ccms-soa-ecs-cluster-admin/ { print $2 }' $properties/$testfile`
sed -i '' 's/soa.test.admin=<INPUT>/soa.test.admin='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$testfile`
sed -i '' 's/soa.test.appA=<INPUT>/soa.test.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$testfile`
sed -i '' 's/soa.test.appB=<INPUT>/soa.test.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$testfile`
sed -i '' 's/soa.test.appC=<INPUT>/soa.test.appC='${output}'/g' $properties/.laaopsproperties

## EDRMS
output=`awk '/eu-west-2a/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/edrms.test.appA=<INPUT>/edrms.test.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/edrms.test.appB=<INPUT>/edrms.test.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/edrms.test.appC=<INPUT>/edrms.test.appC='${output}'/g' $properties/.laaopsproperties

## OPA
output=`awk '/eu-west-2a/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/opa.test.appA=<INPUT>/opa.test.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/opa.test.appB=<INPUT>/opa.test.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/opa.test.appC=<INPUT>/opa.test.appC='${output}'/g' $properties/.laaopsproperties

## PUI
output=`awk '/eu-west-2a/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/pui.test.appA=<INPUT>/pui.test.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/pui.test.appB=<INPUT>/pui.test.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$testfile`
sed -i '' 's/pui.test.appC=<INPUT>/pui.test.appC='${output}'/g' $properties/.laaopsproperties

## PRE-PROD
aws-vault exec laa-staging-lz -- aws ec2 describe-instances \
--filters Name=tag:Name,Values=ccms-* Name=instance-state-name,Values=running \
--query "Reservations [*].Instances[*].{Instance:PrivateIpAddress,AZ:Placement.AvailabilityZone,Name:Tags[?Key=='Name'].Value | [0]}"  \
--output text > $properties/.staging.txt

## EBS
output=`awk '/eu-west-2a/ && /ccms-ebs DB Server/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/ebs.preprod.db=<INPUT>/ebs.preprod.db='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-ebs App Server/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/ebs.preprod.appA=<INPUT>/ebs.preprod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-ebs App Server Two/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/ebs.preprod.appB=<INPUT>/ebs.preprod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-ebs App Server Three/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/ebs.preprod.appC=<INPUT>/ebs.preprod.appC='${output}'/g' $properties/.laaopsproperties

## SOA
output=`awk '/ccms-soa-ecs-cluster-admin/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/soa.preprod.admin=<INPUT>/soa.preprod.admin='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/soa.preprod.appA=<INPUT>/soa.preprod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/soa.preprod.appB=<INPUT>/soa.preprod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/soa.preprod.appC=<INPUT>/soa.preprod.appC='${output}'/g' $properties/.laaopsproperties

## EDRMS
output=`awk '/eu-west-2a/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/edrms.preprod.appA=<INPUT>/edrms.preprod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/edrms.preprod.appB=<INPUT>/edrms.preprod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/edrms.preprod.appC=<INPUT>/edrms.preprod.appC='${output}'/g' $properties/.laaopsproperties

## OPA
output=`awk '/eu-west-2a/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/opa.preprod.appA=<INPUT>/opa.preprod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/opa.preprod.appB=<INPUT>/opa.preprod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/opa.preprod.appC=<INPUT>/opa.preprod.appC='${output}'/g' $properties/.laaopsproperties

## PUI
output=`awk '/eu-west-2a/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/pui.preprod.appA=<INPUT>/pui.preprod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/pui.preprod.appB=<INPUT>/pui.preprod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$preprodfile`
sed -i '' 's/pui.preprod.appC=<INPUT>/pui.preprod.appC='${output}'/g' $properties/.laaopsproperties

## PROD
aws-vault exec laa-production-lz -- aws ec2 describe-instances \
--filters Name=tag:Name,Values=ccms-* Name=instance-state-name,Values=running \
--query "Reservations [*].Instances[*].{Instance:PrivateIpAddress,AZ:Placement.AvailabilityZone,Name:Tags[?Key=='Name'].Value | [0]}"  \
--output text > $properties/.production.txt

## EBS
output=`awk '/eu-west-2a/ && /ccms-ebs DB Server/ { print $2 }' $properties/$prodfile`
sed -i '' 's/ebs.prod.db=<INPUT>/ebs.prod.db='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-ebs App Server/ { print $2 }' $properties/$prodfile`
sed -i '' 's/ebs.prod.appA=<INPUT>/ebs.prod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-ebs App Server Two/ { print $2 }' $properties/$prodfile`
sed -i '' 's/ebs.prod.appB=<INPUT>/ebs.prod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-ebs App Server Three/ { print $2 }' $properties/$prodfile`
sed -i '' 's/ebs.prod.appC=<INPUT>/ebs.prod.appC='${output}'/g' $properties/.laaopsproperties

## SOA
output=`awk '/ccms-soa-ecs-cluster-admin/ { print $2 }' $properties/$prodfile`
sed -i '' 's/soa.prod.admin=<INPUT>/soa.prod.admin='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2a/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$prodfile`
sed -i '' 's/soa.prod.appA=<INPUT>/soa.prod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$prodfile`
sed -i '' 's/soa.prod.appB=<INPUT>/soa.prod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-soa-ecs-cluster-managed/ { print $2 }' $properties/$prodfile`
sed -i '' 's/soa.prod.appC=<INPUT>/soa.prod.appC='${output}'/g' $properties/.laaopsproperties

## EDRMS
output=`awk '/eu-west-2a/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/edrms.prod.appA=<INPUT>/edrms.prod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/edrms.prod.appB=<INPUT>/edrms.prod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-edrms-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/edrms.prod.appC=<INPUT>/edrms.prod.appC='${output}'/g' $properties/.laaopsproperties

## OPA
output=`awk '/eu-west-2a/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/opa.prod.appA=<INPUT>/opa.prod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/opa.prod.appB=<INPUT>/opa.prod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-opa18-hub-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/opa.prod.appC=<INPUT>/opa.prod.appC='${output}'/g' $properties/.laaopsproperties

## PUI
output=`awk '/eu-west-2a/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/pui.prod.appA=<INPUT>/pui.prod.appA='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2b/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/pui.prod.appB=<INPUT>/pui.prod.appB='${output}'/g' $properties/.laaopsproperties
output=`awk '/eu-west-2c/ && /ccms-pui-ecs-cluster/ { print $2 }' $properties/$prodfile`
sed -i '' 's/pui.prod.appC=<INPUT>/pui.prod.appC='${output}'/g' $properties/.laaopsproperties

sed -i '' 's/^.*=$//g' $properties/.laaopsproperties