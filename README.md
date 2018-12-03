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

### Bundle

boostrap script automatically add `$LAMBDA_TASK_ROOT/vim/bundle` to `runtimepath`
