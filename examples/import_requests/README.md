## Lambda to fetch the most recent Github Events

This is the simplest example using the python-lambda-with-requirements module.
It just imports requests and then calls out to Github using the requests API.
We define our dependency requests in the requirements.in file.

```python
import requests

def lambda_handler(event, context):
    r = requests.get('https://api.github.com/events')
    print(r.text)
```

To create the Lambda:
```
terraform init

terraform plan

terraform apply
```
