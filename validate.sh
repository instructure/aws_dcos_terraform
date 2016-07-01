#!/bin/bash

for module in modules/*; do
  terraform validate $module
done
