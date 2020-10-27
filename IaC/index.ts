import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as awsx from "@pulumi/awsx";
import * as random from "@pulumi/random";

// Get default VPC
const vpc = awsx.ec2.Vpc.getDefault();

// Create an Aurora Serverless MySQL database
const dbsubnet = new aws.rds.SubnetGroup("dbsubnet", {
    subnetIds: vpc.privateSubnetIds,
});
const dbpassword = new random.RandomString("password", {
    length: 20,
});
const db = new aws.rds.Cluster("db", {
    engine: "aurora",
    engineMode: "serverless",
    engineVersion: "5.7.12",
    dbSubnetGroupName: dbsubnet.name,
    masterUsername: "root",
    masterPassword: dbpassword.result,
});

// A function to run to connect to our database.
function queryDatabase(): Promise<void> {
    return new Promise((resolve, reject) => {
        var mysql      = require('mysql');
        var connection = mysql.createConnection({
            host     : db.endpoint.get(),
            user     : db.masterUsername.get(),
            password : db.masterPassword.get(),
            database : db.databaseName.get(),
        });

        connection.connect();

        console.log("querying...")
        connection.query('SELECT 1 + 1 AS solution', function (error: any, results: any, fields: any) {
            if (error) { reject(error); return }
            console.log('The solution is: ', results[0].solution);
            resolve();
        });

        connection.end();
    });
}

// Create a Lambda within the VPC to access the Aurora DB and run the code above.
const lambda = new aws.lambda.CallbackFunction("lambda", {
    vpcConfig: {
        securityGroupIds: db.vpcSecurityGroupIds,
        subnetIds: vpc.privateSubnetIds,
    },
    policies: [
        aws.iam.ManagedPolicy.AWSLambdaVPCAccessExecutionRole,
        aws.iam.ManagedPolicy.AWSLambdaFullAccess,
        aws.iam.ManagedPolicy.AmazonRDSFullAccess
    ],
    callback: async(ev) => {
        console.log(ev);

        await queryDatabase();
    },
});

// Export the Function ARN
export const functionArn = lambda.arn;

// Invoke this with:
// $ aws lambda invoke --function-name $(pulumi stack output functionArn) out.txt
// $ pulumi logs -f