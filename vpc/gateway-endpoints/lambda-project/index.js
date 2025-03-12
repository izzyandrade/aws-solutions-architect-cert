const AWS = require('aws-sdk');
const s3 = new AWS.S3();

/**
 * Lambda function that lists objects from an S3 bucket
 * 
 * Expected event structure:
 * {
 *   "bucketName": "your-bucket-name",
 *   "prefix": "path/to/folder/" // optional
 * }
 */
exports.handler = async (event) => {
    // Use the hardcoded bucket name
    const bucketName = 'gateway-endpoint-example-izzy';
    
    // Prepare the parameters for S3 listObjects
    const params = {
        Bucket: bucketName,
        Prefix: event.prefix || ''
    };
    
    try {
        // List objects from S3
        const result = await s3.listObjectsV2(params).promise();
        
        return {
            statusCode: 200,
            body: JSON.stringify({
                message: 'Objects successfully listed from S3',
                bucket: bucketName,
                prefix: params.Prefix,
                count: result.KeyCount,
                objects: result.Contents.map(item => ({
                    key: item.Key,
                    size: item.Size,
                    lastModified: item.LastModified
                }))
            })
        };
    } catch (error) {
        console.error('Error listing objects from S3:', error);
        
        return {
            statusCode: 500,
            body: JSON.stringify({
                message: 'Error listing objects from S3',
                error: error.message
            })
        };
    }
};
