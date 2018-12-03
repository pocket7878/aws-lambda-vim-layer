UNDER DEVELOPMENT


# aws-lambda-vim-layer

Vim layer for AWS Lambda with runtime API.

## Usage


### Build Layer

```
make build
```

will make `lambda-vim-layer.zip`.

### Handler

If you set handler as `handler.Method`, you have to write code into `handler.vim` file and 
it must have `Method` function.

bootstrap will call `Method` with event and context.

```handler.vim
function! Method(eventData, context)
  return a:eventData.message
endfunction
```

#### Context

```
let eventContext = {
  \'memoryLimitInMb' : $AWS_LAMBDA_FUNCTION_MEMORY_SIZE,
  \'functionName' : $AWS_LAMBDA_FUNCTION_NAME,
  \'functionVersion' : $AWS_LAMBDA_FUNCTION_VERSION,
  \'invokedFunctionArm' : eventHeader['Lambda-Runtime-Invoked-Function-Arn'],
  \'xrayTraceId' : eventHeader['Lambda-Runtime-Trace-Id'],
  \'awsRequestId' : eventHeader['Lambda-Runtime-Aws-Request-Id'],
  \'logStreamName' : $AWS_LAMBDA_LOG_STREAM_NAME,
  \'logGroupName' : $AWS_LAMBDA_LOG_GROUP_NAME,
  \'clientContext' : JSON.decode(get(eventHeader, 'Lambda-Runtime-Client-Context', '{}')),
  \'identity' : JSON.decode(get(eventHeader, 'Lambda-Runtime-Cognito-Identity', '{}')),
  \}
```

### Bundle

boostrap script automatically add `$LAMBDA_TASK_ROOT/vim/bundle` to `runtimepath`
