## S3 Select has been shutdown to new customers in 2024

The example in `main.js` is a simple example of how to use S3 Select.

It creates a bucket, uploads a file, and then performs a select operation on the file.

The select operation is performed using the `SelectObjectContentCommand` from the `@aws-sdk/client-s3` package.

The example is written in JavaScript and uses the `import` statement to import the necessary classes from the `@aws-sdk/client-s3` package.

Unfortunately, S3 Select has been shutdown to new customers in 2024. So the command will fail with a `405` error.
If you have used S3 Select before, you can continue to use it and this script will work for you.
