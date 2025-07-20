# capture the HTTP status code to add a variable and write the contents to another file

```bash
# This example uses curl to fetch a URL and capture the HTTP status code.
curl -s -o response.txt -w "%{response_code}" http://example.com
```

- This allows you to check the return code and then decide if the response is worth printing, processing, logging, etc.

```bash
http_response=$(curl -s -o response.txt -w "%{response_code}" http://example.com)
if [ $http_response != "200" ]; then
    # handle error
else
    echo "Server returned:"
    cat response.txt    
fi
```
