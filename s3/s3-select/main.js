import { S3Client, CreateBucketCommand, PutObjectCommand, SelectObjectContentCommand } from "@aws-sdk/client-s3";
import { readFile } from 'fs/promises';

const client = new S3Client({
    region: "sa-east-1",
});

const command = new CreateBucketCommand({
    Bucket: "s3-select-fun-izzy-12345",
});

const createBucketResponse = await client.send(command);

console.log("Bucket Created: ", createBucketResponse.Location);

const fileContent = await readFile('test-file.json');

const uploadCommand = new PutObjectCommand({
    Bucket: "s3-select-fun-izzy-12345",
    Key: "test-file.json",
    Body: fileContent
});

await client.send(uploadCommand);

console.log("File Uploaded successfully");

const selectCommand = new SelectObjectContentCommand({
    Bucket: "s3-select-fun-izzy-12345",
    Key: "test-file.json",
    Expression: "SELECT s.people[*] FROM S3Object s WHERE s.people[*].name = 'Sarah Johnson",
    ExpressionType: 'SQL',
    InputSerialization: {
        JSON: {
            Type: 'DOCUMENT'
        }
    },
    OutputSerialization: {
        JSON: {}
    }
});

await client.send(selectCommand);