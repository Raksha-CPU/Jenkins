# def lambda_handler(event, context):
#     print("Event:", event)
#     return {
#         'statusCode': 200,
#         'body': 'Hello from Lambda!'
#     }

def lambda_handler(event, context):
    if event and 'message' in event:
        return {
            'statusCode': 200,
            'body': f"Message: {event['message']}"
        }
    if event is None:
        return {
            'statusCode': 400,
            'body': "Bad Request"
        }
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda!'
    }
