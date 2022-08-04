echo "Create admin"
aws \
 --endpoint-url=http://localhost:4566 \
 iam create-role \
 --role-name admin-role \
 --path / \
 --assume-role-policy-document file:./admin-policy.json
echo "Make S3 bucket"
aws \
  s3 mb s3://lambda-functions \
  --endpoint-url http://localhost:4566 
echo "Copy the lambda function to the S3 bucket"
aws \
  s3 cp lambdas.zip s3://lambda-functions \
  --endpoint-url http://localhost:4566 
echo "Create the lambda handleCreateNoteRequest"
aws \
  lambda create-function \
  --endpoint-url=http://localhost:4566 \
  --function-name handleCreateNoteRequest \
  --role arn:aws:iam::000000000000:role/admin-role \
  --code S3Bucket=lambda-functions,S3Key=lambdas.zip
  --handler index.handler \
  --runtime nodejs14.x \
  --description "Lambda handler for test." \
  --timeout 60 \
  --memory-size 128 \
echo "Map the testQueue to the lambda function"
echo "All resources initialized! 🚀"