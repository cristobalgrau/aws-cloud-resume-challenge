import boto3

def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table("views-cloud-resume")
    response = table.get_item(Key={"counter": "web"})
    visits = response["Item"]["views"]
    
    visits = visits + 1
    print(visits)
    table.put_item(Item={"counter": "web", "views": visits})

    return visits