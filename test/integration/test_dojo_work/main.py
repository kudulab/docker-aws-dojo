import boto3

session = boto3.session.Session()
current_region = session.region_name
print("Current region is: " + current_region)
