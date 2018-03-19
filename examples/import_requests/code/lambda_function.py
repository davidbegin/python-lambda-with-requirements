import requests
  
def lambda_handler(event, context):
    r = requests.get('https://api.github.com/events')
    print(r.text)
