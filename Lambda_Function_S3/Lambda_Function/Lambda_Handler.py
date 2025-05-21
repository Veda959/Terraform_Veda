import boto3
import os

s3 = boto3.client('s3')
DEST_BUCKET = os.environ['DEST_BUCKET']

def lambda_handler(event, context):
    for record in event['Records']:
        src_bucket = record['s3']['bucket']['name']
        src_key = record['s3']['object']['key']
        
        if src_key.endswith('.txt'):
            copy_source = {'Bucket': src_bucket, 'Key': src_key}
            s3.copy_object(CopySource=copy_source, Bucket=DEST_BUCKET, Key=src_key)
