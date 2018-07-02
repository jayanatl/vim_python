### CentOs

#### Add new trusted CA 
##### Extract SSL Certificate
```openssl s_client -showcerts -verify 5 -connect www.gmail.com:443```

##### Add trusted CA cert to certificate store
```
Add certificate file(s) to /etc/pki/ca-trust/source/anchors/ and execute following command
$ update-ca-trust extract
```

#### Setup env for aws lambda
```
pip3 install awscli ipython boto3 pytest
mkvirtualenv test_lambda
pip install python-lambda
```
