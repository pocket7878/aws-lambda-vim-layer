#!/bin/sh

aws lambda publish-layer-version --layer-name lambda_vim_layer --zip-file fileb://./lambda-vim-layer.zip
