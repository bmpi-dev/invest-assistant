import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import {InstanceType} from "@pulumi/aws/types/enums/ec2";

const config = new pulumi.Config("backend");

// AMI image configuration
const ec2ImageId = 'ami-0885b1f6bd170450c';
const ec2ImageOwner = '099720109477';
const ec2InstanceName = "aws-ec2-ubuntu";
const ec2KeypairName = 'pulumi_key'

const pulumiAmi = pulumi.output(aws.getAmi({
    filters: [{ name: "image-id", values: [ec2ImageId]}],
    owners: [ec2ImageOwner]
}));

const sshPort = 22
const nginxHttpPort = 80
const nginxHttpsPort = 443

const pulumiSecurityGroup = new aws.ec2.SecurityGroup("pulumi-secgrp-backend", {
        ingress: [{
            fromPort: sshPort,
            toPort: sshPort,
            protocol: "tcp",
            cidrBlocks: ["0.0.0.0/0"]
        }, {
            fromPort: 0,
            toPort: 0,
            protocol: "-1",
            cidrBlocks: ["172.31.0.0/16"]
        }, {
            fromPort: nginxHttpPort,
            toPort: nginxHttpPort,
            protocol: "tcp",
            cidrBlocks: ["0.0.0.0/0"]
        }, {
            fromPort: nginxHttpsPort,
            toPort: nginxHttpsPort,
            protocol: "tcp",
            cidrBlocks: ["0.0.0.0/0"]
        }],
        egress: [{
            fromPort: 0,
            toPort: 0,
            protocol: "-1",
            cidrBlocks: ["0.0.0.0/0"]
        }]
    },
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

const domainName = config.require("domainName");
const ec2PublicIp = config.require("ec2PublicIp");

const investI365Tech = aws.route53.getZone({
    name: domainName,
    privateZone: false,
});

const investDomain = new aws.route53.Record("invest", {
    zoneId: investI365Tech.then(investI365Tech => investI365Tech.zoneId),
    name: investI365Tech.then(investI365Tech => `invest.${investI365Tech.name}`),
    type: "A",
    ttl: 300,
    records: [ec2PublicIp],
});

exports.publicIp = ec2Instance.publicIp;
exports.publicHostName = ec2Instance.publicDns;
