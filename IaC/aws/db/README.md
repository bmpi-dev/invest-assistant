## How to use

```
./create_all.sh
ssh -i .ec2ssh/pulumi_key ubuntu@`cat .ec2ssh/db_public_DNS`
sudo su postgres
```