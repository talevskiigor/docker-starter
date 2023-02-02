#!/bin/bash
# docker ps --no-trunc --format "table {{.Names}}\t{{.Status}}\t{{.State}}\t{{.Image}}\t{{.Size}}\t{{.RunningFor}}\t{{.Networks}}"
docker ps --no-trunc --format "table {{.Names}}\t{{.Status}}\t{{.State}}\t{{.Image}}\t{{.RunningFor}}"