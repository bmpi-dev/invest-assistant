import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as awsx from "@pulumi/awsx";
import {InstanceType} from "@pulumi/aws/types/enums/ec2";

// AMI image configuration
const ec2ImageId = 'ami-00ddb0e5626798373';
const ec2ImageOwner = '099720109477';
const ec2InstanceName = "aws-ec2-ubuntu";
const ec2KeypairName = 'pulumi_key'

const pulumiAmi = pulumi.output(aws.getAmi({
    filters: [{ name: "image-id", values: [ec2ImageId]}],
    owners: [ec2ImageOwner]
}));

// const defaultVpc = awsx.ec2.Vpc.getDefault();

const sshPort = 22

const pulumiSecurityGroup = new aws.ec2.SecurityGroup("pulumi-secgrp", {
    ingress: [{
            fromPort: sshPort,
            toPort: sshPort,
            protocol: "tcp",
            cidrBlocks: ["0.0.0.0/0"]
        }]
    }
);

let ec2Instance = new aws.ec2.SpotInstanceRequest(
    ec2InstanceName,
    {
        instanceType: InstanceType.T2_Micro,
        ami: pulumiAmi.id,
        keyName: ec2KeypairName,
        vpcSecurityGroupIds: [pulumiSecurityGroup.id],
        rootBlockDevice: {
            deleteOnTermination: false,
            volumeSize: 10
        }
    }
)

exports.publicIp = ec2Instance.publicIp.apply(res => res);
exports.publicHostName = ec2Instance.publicDns.apply(res => res);
