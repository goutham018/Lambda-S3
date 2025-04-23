import json
import boto3
import os

s3 = boto3.client('s3')
destination_bucket = os.environ['DEST_BUCKET']

def lambda_handler(event, context):
    print("Event: ", json.dumps(event))  # Log the event object
    for record in event.get('Records', []):  # Use .get() to avoid KeyError
        source_bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        
        copy_source = {'Bucket': source_bucket, 'Key': key}
        
        try:
            s3.copy_object(CopySource=copy_source, Bucket=destination_bucket, Key=key)
            print(f'Successfully copied {key} from {source_bucket} to {destination_bucket}')
        except Exception as e:
            print(f'Error copying object: {e}')
            raise e

    return {
        'statusCode': 200,
        'body': json.dumps('Image processed successfully')
    }
