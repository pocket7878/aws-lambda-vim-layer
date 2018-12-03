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

```handler.vim
function! Method()
  return "Hello, Vim"
endfunction
```

### Bundle

boostrap script automatically add `$LAMBDA_TASK_ROOT/vim/bundle` to `runtimepath`
