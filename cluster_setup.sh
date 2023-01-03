#!/bin/bash

kind create cluster --name seldon

kubectl cluster-info --context kind-seldon
